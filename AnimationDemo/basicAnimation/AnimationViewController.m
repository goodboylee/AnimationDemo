//
//  AnimationViewController.m
//  AnimationDemo
//
//  Created by lotus on 2017/10/26.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import "AnimationViewController.h"

#define NORMAL_COLOR    [UIColor cyanColor]
#define SELECTED_COLOR  [UIColor redColor]

typedef NS_ENUM(NSInteger, AnimationType){
    AnimationTypeBasicTanslation = 0,
    AnimationTypeCenterRotation,
    AnimationTypePathRotation,
    AnimationTypeGroup,
    AnimationTypeKeyframe,
    AnimationTypeSpring,
    AnimationTypeOnebyone
};
@interface AnimationViewController ()<CAAnimationDelegate>
{
    AnimationType   _animationType;
    UIButton        *_lastBtn;
    BOOL            _isAnimation;
    CFTimeInterval  _beginTime;
    CFTimeInterval  _endTime;
}

@property (weak, nonatomic) IBOutlet UIButton *animationView;
@property (weak, nonatomic) IBOutlet UIButton *translationBtn;
@property (weak, nonatomic) IBOutlet UIButton *centerRotateBtn;
@property (weak, nonatomic) IBOutlet UIButton *pathRotateBtn;


@end

@implementation AnimationViewController

- (void)awakeFromNib{
    [super awakeFromNib];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"基础动画";
    _animationType = -1;
    
}

#pragma mark - event methods
- (IBAction)animationTypeAction:(UIButton *)sender {
    
    if (_lastBtn == sender) {
        return;
    }
    _lastBtn.backgroundColor = NORMAL_COLOR;
    sender.backgroundColor = SELECTED_COLOR;
    _lastBtn = sender;
    NSUInteger tag = sender.tag;
    if (tag == 0) {
        _animationType = AnimationTypeBasicTanslation;
        [self animationViewReset];
    }else if (tag == 1){
        _animationType = AnimationTypeCenterRotation;
        [self animationViewReset];
    }else if (tag == 2){
        _animationType = AnimationTypePathRotation;
        [self animationViewReset];
    }else if (tag == 3){
        _animationType = AnimationTypeGroup;
        [self animationViewReset];
    }else if (tag == 4){
        _animationType = AnimationTypeKeyframe;
        [self animationViewReset];
    }else if (tag == 5){
        _animationType = AnimationTypeSpring;
        [self animationViewReset];
    }else if (tag == 6){
        _animationType = AnimationTypeOnebyone;
        [self animationViewReset];
    }
    
    
    else if (tag == 100){
        if (_isAnimation) {
            NSLog(@"点击继续");
            [self resumeAnimation:_animationView.layer];
        }
    }else if (tag == 101){
        if (_isAnimation) {
            NSLog(@"点击暂停");
            [self stopAnimation:_animationView.layer];
        }
        
    }else{
        
    }
    
}

- (void)animationViewReset{
    [_animationView.layer removeAllAnimations];
    _animationView.layer.speed = 1.0;
    _animationView.layer.timeOffset = 0.0;
    _animationView.layer.beginTime = 0;
}

- (IBAction)beginAnimation:(id)sender {
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"model value is %f, presentation value is %f", _animationView.layer.modelLayer.position.y, _animationView.layer.presentationLayer.position.y);
//    }];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    if (_animationType < 0) {
        return;
    }
    [self addAnimationWithType:_animationType];
}


#pragma mark - configure animations
- (void)addAnimationWithType:(AnimationType)type{
    if (type == AnimationTypeBasicTanslation) {
        [self configureBasicTranslationAnimationFromValue:nil toValue:nil byValue:@(-200)];
    }else if (type == AnimationTypeCenterRotation){
        [self configureCenterRotationAnimation];
    }else if (type == AnimationTypePathRotation){
        [self configurePathRotationAnimation];
    }else if (type == AnimationTypeGroup){
        [self configureGroupAnimation];
    }else if (type == AnimationTypeKeyframe){
        [self configureKeyframesAnimation];
    }else if (type == AnimationTypeSpring){
        [self configureSpringAnimation];
    }else if (type == AnimationTypeOnebyone){
        [self configureOnebyoneAnimation];
    }
    
    else{
        
    }
}

- (CABasicAnimation *)configureBasicTranslationAnimationFromValue:(id)fromeValue toValue:(id)toValue byValue:(id)byValue{
    //平移动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath: @"position.y"];
    
    //这个if clause只是为了演示方便,项目在中请根据实际情况处理相关逻辑
    if (byValue) {
        //该属性表示相对值，如果不需要明确开始和结束的值，可以使用该属性代替fromValue和toValue
        basicAnimation.byValue = byValue;
    }else{
        basicAnimation.fromValue = fromeValue;
        basicAnimation.toValue = toValue;
    }
    
    //fillMode和removedOnCompletion搭配，最常用的就是保持动画结束时候的状态,除非有必要，否则不要这样设置，会有离屏渲染，增加性能损耗
//    basicAnimation.fillMode = kCAFillModeForwards;
//    basicAnimation.removedOnCompletion = NO;
    
    
    
    if (_animationType != AnimationTypeGroup) {
        basicAnimation.duration = 1.0;//动画时间
        basicAnimation.repeatCount = 1;
        [_animationView.layer addAnimation:basicAnimation forKey:nil];
    }
    
    return basicAnimation;
}
- (CABasicAnimation *)configureCenterRotationAnimation{
    //旋转动画:最常用的就是围绕z轴旋转transform.rotation.z，transform的其他设置还有平移transform.translation、缩放transform.rotation,分别也有相对应的x、y、z方向,可以自己玩玩查看相对应效果
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.fromValue = @(0);
    rotateAnimation.toValue = @(M_PI * 2);
    
    
    if (_animationType != AnimationTypeGroup) {
        rotateAnimation.duration = 1.0;
        rotateAnimation.repeatCount = MAXFLOAT;//MAXFLOAT无限循环
        [_animationView.layer addAnimation:rotateAnimation forKey:nil];
    }
    
    return rotateAnimation;
}
- (CAKeyframeAnimation *)configurePathRotationAnimation{
    //帧动画
    //按照路径进行动画,该例子中是围绕一个圆进行动画
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, _animationView.center.x, _animationView.center.y, 80, M_PI * 2, 0, true);
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.path = path;
    CGPathRelease(path);
    
    //该属性表示动画结束后会逆向原路返回远点
    //    keyAnimation.autoreverses = YES;
    
    //旋转模式，是否打开自旋转，可以这样比喻地球围绕太阳公转，地球也有自转。若不需要自转则不用设置该属性
    keyAnimation.rotationMode = kCAAnimationRotateAuto;
    
    //匀速，其他效果自己玩
    keyAnimation.calculationMode = kCAAnimationPaced;
    
    if (_animationType != AnimationTypeGroup) {
        keyAnimation.duration = 5.0;
        keyAnimation.repeatCount = 1;
        [_animationView.layer addAnimation:keyAnimation forKey:nil];
    }
    
    return keyAnimation;
}

- (void)configureKeyframesAnimation{
    _animationView.transform =CGAffineTransformMakeRotation(M_PI_4);
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGPoint point_1 = CGPointMake(_animationView.center.x, _animationView.center.y);
    CGPoint point_2 = CGPointMake(point_1.x + 20, point_1.y - 20);
    CGPoint point_3 = CGPointMake(point_2.x + 130, point_2.y - 130);
    CGPoint point_4 = CGPointMake(point_3.x, point_1.y);
    
    NSValue *value_1 = [NSValue valueWithCGPoint:point_1];
    NSValue *value_2 = [NSValue valueWithCGPoint:point_2];
    NSValue *value_3 = [NSValue valueWithCGPoint:point_3];
    NSValue *value_4 = [NSValue valueWithCGPoint:point_4];
    animation.values = @[value_1, value_2,value_3,value_4];
    
    animation.repeatCount = 1;
    animation.duration = 3.0f;
    
    //一般来讲该属性的count必须和values属性的count一致，且后一个数必须大于或者等于后一个数
    //如果calculationMode =  kCAAnimationLinear or kCAAnimationCubic,keytimes属性中的第一个数必须是0，最后一个必须是1；如果是kCAAnimationDiscrete，keytimes属性中的第一个数必须是0，最后一个数必须是1，而且keytimes属性的数组元素个数比values中的多一个；如果是kCAAnimationPaced or kCAAnimationCubicPaced，则该属性不起作用。
    animation.keyTimes = @[@(0.0), @(0.2), @(0.6), @(1.0)];
    animation.calculationMode = kCAAnimationCubic;
    
    animation.delegate = self;
    [_animationView.layer addAnimation:animation forKey:nil];
    
}
- (void)configureGroupAnimation{
    
    //组合动画：动画间不能有冲突，又要按圆路径动画，又要沿y轴移动，这很明显不行的，可以打开数组的那个注释试下效果.
    //如果还 需要其他 动画，可以继续添加.
    CABasicAnimation *basicAnimation = [self configureBasicTranslationAnimationFromValue:nil toValue:nil byValue:@(-200)];
    CABasicAnimation *centerRotateAnimation = [self configureCenterRotationAnimation];
    //CAKeyframeAnimation *pathAnimation = [self configurePathRotationAnimation];
    
    CAAnimationGroup *groupAnimations = [CAAnimationGroup animation];
    groupAnimations.animations = @[basicAnimation, centerRotateAnimation/*, pathAnimation*/];
    groupAnimations.duration = 2.0;
    groupAnimations.repeatCount = 1;
    
    [_animationView.layer addAnimation:groupAnimations forKey:nil];
}

- (void)configureSpringAnimation{
    //弹簧动画
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"position.x"];
    springAnimation.duration = 3.0;
    springAnimation.repeatCount = 1.0;
    springAnimation.fromValue = @(50);
    springAnimation.toValue = @([UIScreen mainScreen].bounds.size.width - 50);
    springAnimation.delegate = self;
    
    //阻尼:值越大 settling time 越小
    springAnimation.damping = 1;
    
    //质量:值越大 弹性效果越强 振动次数越多 settling time越大
//    springAnimation.mass = 0.5;
    
    //弹簧的劲度（刚度）:值越大 振动次数越少 settling time越小
//    springAnimation.stiffness = 10;
    
    //初速度 有初速度的话 settling time肯定越大, 正负值只是代表方向
    springAnimation.initialVelocity = -5;
    
    [_animationView.layer addAnimation:springAnimation forKey:nil];
    
    NSLog(@"settling time is %f", springAnimation.settlingDuration);
}

- (void)configureOnebyoneAnimation{
    
    //上升
    CABasicAnimation *animation_1 = [CABasicAnimation animationWithKeyPath: @"position.y"];
    animation_1.byValue = @(-200);
    animation_1.duration = 1.0;//动画时间

    //下降
    CABasicAnimation *animation_2 = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation_2.fromValue = @(_animationView.frame.origin.y - 200);
    animation_2.toValue = @(_animationView.frame.origin.y);
    animation_2.duration = 1.0;
    animation_2.beginTime = CACurrentMediaTime() + 1;

    //无限自转
    CABasicAnimation *animation_3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation_3.fromValue = @(0);
    animation_3.toValue = @(M_PI * 2);
    animation_3.duration = 0.2;
    animation_3.repeatCount = MAXFLOAT;
    animation_3.beginTime = CACurrentMediaTime() + 1;
    
    //回到原点去除动画
    [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [_animationView.layer removeAllAnimations];
    }];
    
    [_animationView.layer addAnimation:animation_1 forKey:nil];
    [_animationView.layer addAnimation:animation_2 forKey:nil];
    [_animationView.layer addAnimation:animation_3 forKey:nil];
}


#pragma mark - 动画 暂停/继续
- (void)stopAnimation:(CALayer *)layer{
    
    CFTimeInterval pauseTime = [layer convertTime:CACurrentMediaTime() toLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pauseTime;
    
    NSLog(@"begin time: %f, pause time: %f", layer.beginTime, pauseTime);
    
}

- (void)resumeAnimation:(CALayer *)layer{
    CFTimeInterval pauseTime = layer.timeOffset;
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    
    CFTimeInterval currentTime = [layer convertTime:CACurrentMediaTime() toLayer:nil];
    CFTimeInterval timeSincePause = currentTime  - pauseTime;
    
    NSLog(@"pause time: %f, current time: %f, timeoffset : %f", pauseTime, currentTime, timeSincePause);
    layer.beginTime = timeSincePause;
}


#pragma mark - animation delegates
- (void)animationDidStart:(CAAnimation *)anim{
    _isAnimation = YES;
    _beginTime = CACurrentMediaTime();
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        _isAnimation = NO;
        _animationView.transform = CGAffineTransformIdentity;
        
        _endTime = CACurrentMediaTime();
        NSLog(@"animation time is %f", _endTime - _beginTime);
        [self animationViewReset];
    }
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  GradientNExtViewController.m
//  AnimationDemo
//
//  Created by lotus on 2017/11/28.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import "GradientNExtViewController.h"
#import "GradientLastViewController.h"

static NSInteger const circleDuarationTime = 1;

@interface GradientNExtViewController ()
{
    CAGradientLayer *_leftGradientLayer;
    CAGradientLayer *_rightGradientLayer;
}

@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageview;
@property (weak, nonatomic) IBOutlet UIImageView *frontImageview;

@end

@implementation GradientNExtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    [self configureLayerForCircleView];
    [self configureLayerForFrontImageview];
}

- (void)initViews{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextVC)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    _leftGradientLayer.frame = CGRectMake(0, 0, _frontImageview.bounds.size.width / 2, _frontImageview.bounds.size.height * 3);
    _rightGradientLayer.frame = CGRectMake(_frontImageview.bounds.size.width / 2, 0, _frontImageview.bounds.size.width / 2, _frontImageview.bounds.size.height * 3);
}

#pragma mark - event methods
- (void)nextVC{
    GradientLastViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GradientLastViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)configureLayerForCircleView{
    
    //1. add the gradient layer to circleview's layer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = _circleView.bounds;
    gradientLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor purpleColor].CGColor, (id)[UIColor redColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    
    //u should init a location here or the animation will not be made.
    gradientLayer.locations = @[@(-0.11), @(-0.1), @(0)];
    [_circleView.layer addSublayer:gradientLayer];
    
    //2. add a mask layer to the gradient layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    //prepare a path for the shapeLayer
    CGPoint circleCenter = CGPointMake(_circleView.bounds.size.width / 2, _circleView.bounds.size.height / 2);
    NSInteger radius = ceil( _circleView.bounds.size.height) / 2 - 5;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:circleCenter radius:radius startAngle:0 endAngle:M_PI *2 clockwise:YES];
    
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 5.0;
    
    gradientLayer.mask = shapeLayer;
    
    //3. set up a timer to change gradient layer's locations property
    [NSTimer scheduledTimerWithTimeInterval:circleDuarationTime repeats:YES block:^(NSTimer * _Nonnull timer) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
        animation.fromValue = @[@(-0.11), @(-0.1), @(0)];
        animation.toValue = @[@(1), @(1.1), @(1.2)];
        animation.duration = circleDuarationTime;
        [gradientLayer addAnimation:animation forKey:nil];
    }];
}

- (void)configureLayerForFrontImageview{
    
    //1. add a mask to front image view
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = _frontImageview.bounds;
    maskLayer.backgroundColor = [UIColor clearColor].CGColor;
    _frontImageview.layer.mask = maskLayer;
    
    //add the left side layer to the mask layer
    _leftGradientLayer = [CAGradientLayer layer];
    _leftGradientLayer.frame = CGRectMake(0, 0, _frontImageview.bounds.size.width / 2, _frontImageview.bounds.size.height * 3);
    _leftGradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
    _leftGradientLayer.locations = @[@(0.4), @(0.5)];
    [maskLayer addSublayer:_leftGradientLayer];
    
    //add the right side layer to the mask layer
    _rightGradientLayer = [CAGradientLayer layer];
    _rightGradientLayer.frame = CGRectMake(_frontImageview.bounds.size.width / 2, 0, _frontImageview.bounds.size.width / 2, _frontImageview.bounds.size.height * 3);
    _rightGradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
    _rightGradientLayer.locations = @[@(0.4), @(0.5)];
    [maskLayer addSublayer:_rightGradientLayer];
    
    //animation to show bg image view
    [self showBgImage];
}

- (void)showBgImage{
    
    [NSTimer scheduledTimerWithTimeInterval:circleDuarationTime repeats:NO block:^(NSTimer * _Nonnull timer) {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(_leftGradientLayer.position.x, _leftGradientLayer.position.y - _leftGradientLayer.bounds.size.height * 0.5)];
        animation.duration = circleDuarationTime;
        
        //keep the animation last state
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        
        [_leftGradientLayer addAnimation:animation forKey:nil];
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:circleDuarationTime + 2 repeats:NO block:^(NSTimer * _Nonnull timer) {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(_rightGradientLayer.position.x, _rightGradientLayer.position.y - _rightGradientLayer.bounds.size.height * 0.5)];
        animation.duration = circleDuarationTime;
        
        //keep the animation last state
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        
        [_rightGradientLayer addAnimation:animation forKey:nil];
    }];
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

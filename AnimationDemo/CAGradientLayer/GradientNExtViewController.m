//
//  GradientNExtViewController.m
//  AnimationDemo
//
//  Created by lotus on 2017/11/28.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import "GradientNExtViewController.h"

static NSInteger const circleDuarationTime = 1;

@interface GradientNExtViewController ()


@property (weak, nonatomic) IBOutlet UIView *circleView;
@end

@implementation GradientNExtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureLayerForCircleView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    
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

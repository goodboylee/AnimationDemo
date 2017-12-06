//
//  ReplicatorViewController.m
//  AnimationDemo
//
//  Created by Lotus on 2017/12/6.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import "ReplicatorViewController.h"

static NSInteger const space = 30;
static NSInteger const earthDiameter = 25;
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height


@interface ReplicatorViewController ()
{
    CAReplicatorLayer *_rpLayer;
}
@property (strong, nonatomic) IBOutlet UIImageView *sunImageview;
@property (strong, nonatomic) UIImageView *earthImageview;

@end

@implementation ReplicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_useType == RpUseAnimation) {
        [self  configureReplicatorLayer];
    }else if (_useType == RpUseTransform){
        [self configureRepicatorSquareLayer];
    }else if (_useType == RpUseSubRp){
        [self configureRepicatorLayerWithSubRp];
    }
    
}

- (void)initViews{
    
    UIImageView *imgview_1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH- space- earthDiameter, self.view.center.y - earthDiameter / 2, earthDiameter, earthDiameter)];
    imgview_1.image = [UIImage imageNamed:@"earth"];
    _earthImageview = imgview_1;
}


- (void)configureReplicatorLayer{
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.view.bounds;
    replicatorLayer.instanceCount = 20;
    replicatorLayer.instanceDelay = 0.5;
    _rpLayer = replicatorLayer;
    [_rpLayer addSublayer:_earthImageview.layer];
    [self.view.layer addSublayer:_rpLayer];
    
    
    NSInteger radius = (SCREEN_WIDTH - earthDiameter - space * 2) / 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.path = path.CGPath;
    keyAnimation.duration = 10.0;
    keyAnimation.repeatCount = MAXFLOAT;
    
    [_earthImageview.layer addAnimation:keyAnimation forKey:nil];
    
}

- (void)configureRepicatorSquareLayer{
    NSInteger count = 5;
    //color offset
    CGFloat offset = -1.0 / count;
    
    CALayer *redLayer = [CALayer layer];
    redLayer.frame = CGRectMake(10, 200, 50, 50);
    redLayer.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0.8 alpha:1].CGColor;
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.view.bounds;
    replicatorLayer.instanceCount = count;
    replicatorLayer.instanceDelay = 2;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(60, 0, 0);
    
    replicatorLayer.instanceGreenOffset = offset;
    replicatorLayer.instanceBlueOffset = offset;
    
    _rpLayer = replicatorLayer;
    
    [_rpLayer addSublayer:redLayer];
    [self.view.layer addSublayer:_rpLayer];
    
    
}

- (void)configureRepicatorLayerWithSubRp{
    NSInteger count = 5;
    //color offset
    CGFloat offset = -1.0 / count;
    
    CALayer *redLayer = [CALayer layer];
    redLayer.frame = CGRectMake(10, 200, 50, 50);
    redLayer.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0.8 alpha:1].CGColor;
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.view.bounds;
    replicatorLayer.instanceCount = count;
    replicatorLayer.instanceDelay = 2;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(60, 0, 0);
    
    replicatorLayer.instanceGreenOffset = offset;
    replicatorLayer.instanceBlueOffset = offset;
    
    _rpLayer = replicatorLayer;
    
    
    CAReplicatorLayer *outerRp = [CAReplicatorLayer layer];
    outerRp.frame = self.view.bounds;
    outerRp.instanceCount = count;
    outerRp.instanceDelay = 3;
    outerRp.instanceTransform = CATransform3DMakeTranslation(0, 60, 0);
    outerRp.instanceRedOffset = offset;
    
    [_rpLayer addSublayer:redLayer];
    [outerRp addSublayer:_rpLayer];
    [self.view.layer addSublayer:outerRp];
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

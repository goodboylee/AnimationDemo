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
    
    [self  configureReplicatorLayer];
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
    [self.view.layer addSublayer:_rpLayer];
    [replicatorLayer addSublayer:_earthImageview.layer];
    
    NSInteger radius = (SCREEN_WIDTH - earthDiameter - space * 2) / 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.path = path.CGPath;
    keyAnimation.duration = 10.0;
    keyAnimation.repeatCount = MAXFLOAT;
    
    [_earthImageview.layer addAnimation:keyAnimation forKey:nil];
    
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

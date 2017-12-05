//
//  ReplicatorViewController.m
//  AnimationDemo
//
//  Created by Lotus on 2017/12/6.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import "ReplicatorViewController.h"

@interface ReplicatorViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *sunImageview;
@property (weak, nonatomic) IBOutlet UIImageView *earthImageview;

@end

@implementation ReplicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureReplicatorLayer];
}

- (void)configureReplicatorLayer{
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.view.bounds;
    replicatorLayer.instanceCount = 100;
    replicatorLayer.instanceDelay = 0.5;
    [self.view.layer addSublayer:replicatorLayer];
    [replicatorLayer addSublayer:_sunImageview.layer];
    [replicatorLayer addSublayer:_earthImageview.layer];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    NSInteger radius = (size.width - _earthImageview.bounds.size.width - 30) / 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:_sunImageview.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.path = path.CGPath;
    keyAnimation.duration = 10.0;
    
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

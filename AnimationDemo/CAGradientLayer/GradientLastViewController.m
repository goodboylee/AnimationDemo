//
//  GradientLastViewController.m
//  AnimationDemo
//
//  Created by lotus on 2017/11/29.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import "GradientLastViewController.h"

@interface GradientLastViewController ()
{
    CAGradientLayer *_gradientLayer;
}
@property (weak, nonatomic) IBOutlet UIImageView *bgImageview;
@property (weak, nonatomic) IBOutlet UIImageView *frontImageview;

@end

@implementation GradientLastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"mask整体移动";
    [self configureLayerForImageview];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    _gradientLayer.frame = CGRectMake(0, 0, _frontImageview.bounds.size.width, _frontImageview.bounds.size.height * 3);
    
}

- (void)configureLayerForImageview{
    
    //1. add mask to front imageview
    CAGradientLayer *tempLayer = [CAGradientLayer layer];
    tempLayer.frame = CGRectMake(0, 0, _frontImageview.bounds.size.width, _frontImageview.bounds.size.height * 3);
    tempLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor cyanColor].CGColor];
    tempLayer.locations = @[@(0.4), @(0.5)];
    _gradientLayer = tempLayer;
    _frontImageview.layer.mask = _gradientLayer;
    
    [self showBgImageview];
}

- (void)showBgImageview{
    
    [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer * _Nonnull timer) {
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(_gradientLayer.position.x, _gradientLayer.position.y - _gradientLayer.bounds.size.height * 0.5)];
        animation.duration = 2;
        
        //keep the animation last state
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        
        [_gradientLayer addAnimation:animation forKey:nil];
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

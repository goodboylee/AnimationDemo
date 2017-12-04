//
//  EmitterFireViewController.m
//  AnimationDemo
//
//  Created by lotus on 2017/12/4.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import "EmitterFireViewController.h"

@interface EmitterFireViewController ()
{
    CAEmitterLayer *_emitterLayer;
}
@property (weak, nonatomic) IBOutlet UISlider *slider;
@end

@implementation EmitterFireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    _slider.transform = CGAffineTransformMakeRotation(M_PI_2);
    [self configureFireLayer];
}


- (void)configureFireLayer{
    
    //1. configure emitter cell
    CAEmitterCell* fire = [CAEmitterCell emitterCell];
    fire.emissionLongitude =   M_PI_2 ;//lotus
    fire.birthRate = 50;
    fire.velocity = 80;
//    fire.velocityRange = 30;
    fire.emissionRange = 1.1;
//    fire.yAcceleration = -60;
    fire.scaleSpeed = 0.3;
    CGColorRef color = [UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1].CGColor;
    fire.color = color;
//    fire.contents = (id) [self CGImageNamed:@"fire.png"];
    fire.contents = (id)[UIImage imageNamed:@"fire"].CGImage;
    fire.lifetime = 1.0;
    
    //Name the cell so that it can be animated later using keypaths
    [fire setName:@"fireCell"];
    
    //2. configure emitter layer
     CAEmitterLayer *tempLayer = [CAEmitterLayer layer];
    tempLayer = [CAEmitterLayer layer];
    tempLayer.emitterPosition = CGPointMake(self.view.center.x, self.view.center.y);
    tempLayer.emitterMode = kCAEmitterLayerOutline;
    tempLayer.emitterShape = kCAEmitterLayerLine;
    tempLayer.renderMode = kCAEmitterLayerAdditive;
    tempLayer.emitterSize = CGSizeMake(0, 0);
    
    
    tempLayer.emitterCells = @[fire];
    _emitterLayer = tempLayer;
    [self.view.layer addSublayer:_emitterLayer];

    
}

- (IBAction)sliderAction:(UISlider *)sender {
    
    float gas = sender.value / 100.0;
    
    //Update the fire properties
    [_emitterLayer setValue:[NSNumber numberWithInt:(gas * 300)] forKeyPath:@"emitterCells.fireCell.birthRate"];
    [_emitterLayer setValue:[NSNumber numberWithFloat:gas] forKeyPath:@"emitterCells.fireCell.lifetime"];
    [_emitterLayer setValue:[NSNumber numberWithFloat:(gas * 0.35)] forKeyPath:@"emitterCells.fireCell.lifetimeRange"];
    _emitterLayer.emitterSize = CGSizeMake(20 * gas, 0);
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

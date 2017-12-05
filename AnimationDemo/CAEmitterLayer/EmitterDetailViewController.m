//
//  EmitterDetailViewController.m
//  AnimationDemo
//
//  Created by lotus on 2017/12/5.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import "EmitterDetailViewController.h"

@interface EmitterDetailViewController ()
{
    CAEmitterLayer *_fireEmitrer;
    CAEmitterLayer *_snowEmitter;
    CAEmitterLayer *_sparkleEmitter;
    
    CADisplayLink *_timer;
}
@property (weak, nonatomic) IBOutlet UISlider *slider;


@end

@implementation EmitterDetailViewController

- (void)dealloc{
    if (_timer) {
        [_timer removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [_timer invalidate];
        _timer = nil;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _slider.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self  configureTitle];
    [self configureEmitterWithType:_emitterType];
    
    if (_emitterType == EmitterTypeSparkle) {
        [self setupTimer];
    }
}

- (void)setupTimer{
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeColor:)];
    [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
     
- (void)configureTitle{
    switch (_emitterType) {
        case EmitterTypeFire:
            self.title = @"火焰效果";
            break;
        case EmitterTypeSnow:
            self.title = @"雪花效果";
            break;
        case EmitterTypeSparkle:
            self.title = @"烟花效果";
            break;
    }
}

- (void)configureEmitterWithType:(EmitterType)type{
    
    switch (type) {
        case EmitterTypeFire:
            [self configureFireEmitter];
            break;
        case EmitterTypeSnow:
            [self configureSnowEmitter];
            break;
        case EmitterTypeSparkle:
            [self configureSparkleEmitter];
            break;
    }
}



- (void)configureFireEmitter{
    
    CAEmitterLayer *tmpEmitter = [CAEmitterLayer layer];
    tmpEmitter.frame = self.view.bounds;
    tmpEmitter.emitterPosition = CGPointMake(self.view.center.x, CGRectGetMaxY(self.view.frame) - 50);
    tmpEmitter.emitterShape = kCAEmitterLayerLine;
    tmpEmitter.emitterMode = kCAEmitterLayerOutline;
    tmpEmitter.renderMode = kCAEmitterLayerAdditive;
    _fireEmitrer = tmpEmitter;
    [self.view.layer addSublayer:_fireEmitrer];
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.name = @"fireCell";
    cell.birthRate = 200;
    cell.lifetime = 1.0;
    cell.lifetimeRange = 0.35;
    cell.velocity = 80;
    cell.emissionRange = M_PI / 6;
    cell.yAcceleration = -100;
    cell.scaleSpeed = 0.3;
    cell.contents = (id)[UIImage imageNamed:@"fire"].CGImage;
    cell.color = [UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1].CGColor;
    
    _fireEmitrer.emitterCells = @[cell];
}


- (void)configureSnowEmitter{
    CAEmitterLayer *tmpEmitter = [CAEmitterLayer layer];
    tmpEmitter.frame = self.view.bounds;
    tmpEmitter.emitterPosition = CGPointMake(self.view.center.x, 0);
    tmpEmitter.emitterShape = kCAEmitterLayerLine;
    tmpEmitter.emitterMode = kCAEmitterLayerOutline;
    tmpEmitter.renderMode = kCAEmitterLayerAdditive;
    tmpEmitter.emitterSize = CGSizeMake(self.view.bounds.size.width, 0);
    _snowEmitter = tmpEmitter;
    [self.view.layer addSublayer:_snowEmitter];
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.name = @"snowCell";
    cell.birthRate = 5;
    cell.lifetime = 10.0;
    cell.lifetimeRange = 0.35;
    cell.velocity = -30;
    cell.yAcceleration = 5;
    cell.spin = M_PI_4;
    cell.spinRange = 0.3;
    cell.contents = (id)[UIImage imageNamed:@"snow"].CGImage;
    
    _snowEmitter.emitterCells = @[cell];
}

- (void)configureSparkleEmitter{
    CAEmitterLayer *tmpEmitter = [CAEmitterLayer layer];
    tmpEmitter.frame = self.view.bounds;
    tmpEmitter.emitterPosition = self.view.center;
    tmpEmitter.emitterShape = kCAEmitterLayerPoint;
    tmpEmitter.emitterMode = kCAEmitterLayerPoints;
    tmpEmitter.renderMode = kCAEmitterLayerAdditive;
    _sparkleEmitter = tmpEmitter;
    [self.view.layer addSublayer:_sparkleEmitter];
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.name = @"sparkleCell";
    cell.birthRate = 200;
    
    cell.lifetime = 1.5;
    cell.lifetimeRange = 0.35;
    
    cell.velocity = 100;
    cell.velocityRange = 40;
//    cell.yAcceleration = -100;
    
    cell.emissionRange = M_PI * 2;
//    cell.scaleSpeed = 0.3;
    
    cell.alphaSpeed = -0.1;
    cell.redSpeed = -0.1;
    cell.greenRange = 0.1;
    cell.blueRange = 0.2;
    
    cell.contents = (id)[UIImage imageNamed:@"sparkle"].CGImage;
//    cell.color = [UIColor colorWithRed:211/255.0 green:11/255.0 blue:15/255.0 alpha:0.5].CGColor;
    
    _sparkleEmitter.emitterCells = @[cell];
}

- (void)changeColor:(CADisplayLink *)timer{
    float red = arc4random() % 255 + 1;
    float green = arc4random() % 255 + 1;
    float blue = arc4random() %255 + 1;
    
    CGColorRef color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1].CGColor;
    [_sparkleEmitter setValue:(__bridge id)color forKeyPath:@"emitterCells.sparkleCell.color"];
}


#pragma mark - event methods

- (IBAction)sliderAction:(UISlider *)sender {
    
    float value = sender.value / 100;
    
    [self changeValue:value];
}

- (void)changeValue:(float)value{
    switch (_emitterType) {
        case EmitterTypeFire:
            [_fireEmitrer setValue:@(value * 200)   forKeyPath:@"emitterCells.fireCell.birthRate"];
            [_fireEmitrer setValue:@(value)         forKeyPath:@"emitterCells.fireCell.lifetime"];
            [_fireEmitrer setValue:@(value * 0.35)  forKeyPath:@"emitterCells.fireCell.lifetimeRange"];
            [_fireEmitrer setEmitterSize:CGSizeMake(value * 20, 0)];
            
            break;
        case EmitterTypeSnow:
            [_snowEmitter setValue:@(value * 20)   forKeyPath:@"emitterCells.snowCell.birthRate"];
            break;
        case EmitterTypeSparkle:
            [_sparkleEmitter setValue:@(value * 200)   forKeyPath:@"emitterCells.sparkleCell.birthRate"];
            break;
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

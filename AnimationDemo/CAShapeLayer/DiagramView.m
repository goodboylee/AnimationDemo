
//  GraphicView.m
//  AnimationDemo
//
//  Created by lotus on 2017/11/27.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import "DiagramView.h"

@interface DiagramView()
{
    CAShapeLayer *_shapeLayer;
    NSArray *_values;
    NSMutableArray <CAShapeLayer *>*_layers;
}
@end
@implementation DiagramView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        [self initData];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
    }
    return self;
}
- (void)initData{
    _values = @[@(30), @(120), @(50)];
    _layers = [NSMutableArray array];
}
- (void)addDiagram:(BOOL)animated{
    
    if (_layers.count) {
        [_layers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    }
    
    NSInteger width = 50;
    NSInteger num = _values.count;
    NSInteger space = (self.bounds.size.width - num * width) / (num + 1);
    NSInteger maxY = self.bounds.size.height;
    
    for (NSInteger i = 0; i < num; i++) {
        
        NSInteger startX = space + (width + space)* i + width / 2;
        NSInteger valueY = maxY - [_values[i] integerValue];
        //path
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(startX, maxY)];
        [path addLineToPoint:CGPointMake(startX, valueY)];
        
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
        shapeLayer.lineWidth = width;
        
        [_layers addObject:shapeLayer];
        //add the layer to self layer
        [self.layer addSublayer:shapeLayer];
        
        //add animaiton to shapeLayer
        if (animated) {
            CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            basicAnimation.fromValue = @(0);
            basicAnimation.toValue = @(1);
            basicAnimation.duration = 0.5;
            basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            
            //don't remove the animation's last status when completed
            basicAnimation.removedOnCompletion = NO;
            basicAnimation.fillMode = kCAFillModeForwards;
            [shapeLayer addAnimation:basicAnimation forKey:nil];
        }
        
    }
    
}

- (void)addDiagram_1:(BOOL)animated{
    if (_layers.count) {
        [_layers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    }
    
    NSInteger width = 50;
    NSInteger num = _values.count;
    NSInteger space = (self.bounds.size.width - num * width) / (num + 1);
    NSInteger maxY = self.bounds.size.height;
    
    
    NSInteger startX = space + width / 2;
    //path
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(startX, maxY)];
    [path addLineToPoint:CGPointMake(startX, maxY - 50)];
    
    startX = space * 2 + width + width / 2;
    [path moveToPoint:CGPointMake(startX, maxY)];
    [path addLineToPoint:CGPointMake(startX, maxY - 100)];
    
    startX = space * 3 + width * 2 + width / 2;
    [path moveToPoint:CGPointMake(startX, maxY)];
    [path addLineToPoint:CGPointMake(startX, maxY - 80)];
        
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
    shapeLayer.lineWidth = width;
    
    [_layers addObject:shapeLayer];
    //add the layer to self layer
    [self.layer addSublayer:shapeLayer];
    
    //add animaiton to shapeLayer
    if (animated) {
        CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        basicAnimation.fromValue = @(0);
        basicAnimation.toValue = @(1);
        basicAnimation.duration = 0.6;
        basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        //don't remove the animation's last status when completed
        basicAnimation.removedOnCompletion = NO;
        basicAnimation.fillMode = kCAFillModeForwards;
        [shapeLayer addAnimation:basicAnimation forKey:nil];
    }
        

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
}


@end

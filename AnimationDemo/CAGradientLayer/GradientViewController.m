//
//  GradientViewController.m
//  AnimationDemo
//
//  Created by lotus on 2017/11/28.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import "GradientViewController.h"
#import "GradientNExtViewController.h"

@interface GradientViewController ()
{
    CGFloat _progress;
    CALayer *_maskLayer;
    CAGradientLayer *_gradientLayerForFirstBtmView;
    CAGradientLayer *_gradientLayerForSecondBtmView;
}
@property (weak, nonatomic) IBOutlet UIImageView *beautyView;
@property (weak, nonatomic) IBOutlet UIView *firstBottomView;
@property (weak, nonatomic) IBOutlet UIView *secondBottomView;

@end

@implementation GradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initViews];
    [self configureGradientToImageview];
    [self configureGradientToFirstBottomView];
    [self configureGradientLayerToSecondBottomView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    //u should init frame here, while u use autolayout.
    //configure frames
    _gradientLayerForFirstBtmView.frame = _firstBottomView.bounds;
    _gradientLayerForSecondBtmView.frame = _secondBottomView.bounds;
}

- (void)initData{
    _progress = 0;
}
- (void)initViews{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextVC)];
    self.navigationItem.rightBarButtonItem = item;
}


#pragma mark - event methods
- (void)nextVC{
    GradientNExtViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GradientNExtViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - configure layer for views
- (void)configureGradientToImageview{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = _beautyView.bounds;
    gradientLayer.colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor clearColor].CGColor];
    
    //the locations's value is between 0 and 1 according to the document,  but it can work when it's nagative. I don't know why.
    gradientLayer.locations = @[@(-1), @(1)];
    [_beautyView.layer addSublayer:gradientLayer];
    
}

- (void)configureGradientToFirstBottomView{
    
    _gradientLayerForFirstBtmView = [CAGradientLayer layer];
    [self setupLayer:_gradientLayerForFirstBtmView];
    
    [_firstBottomView.layer addSublayer:_gradientLayerForFirstBtmView];
    
    _maskLayer = [CALayer layer];
    _maskLayer.frame = CGRectMake(0, 0, 0, _firstBottomView.bounds.size.height);
    
    //configure color except for clearColor
    _maskLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    _gradientLayerForFirstBtmView.mask = _maskLayer;
    
    //configure timer to update maskLayer's frame
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateMask:) userInfo:nil repeats:YES];
}

- ( void)configureGradientLayerToSecondBottomView{
    _gradientLayerForSecondBtmView = [CAGradientLayer layer];
    [self setupLayer:_gradientLayerForSecondBtmView];
    
    [_secondBottomView.layer addSublayer:_gradientLayerForSecondBtmView];
    
    //configure timer to update the gradient layer's colors
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateColor:) userInfo:nil repeats:YES];
}

#pragma mark - timer methods
- ( void)updateMask:(NSTimer *)timer{

    //reset progress
    if (_progress > 1) {
        _progress = 0;
        return;
    }
    
    //change the mask layer's frame
    CGRect frame = _firstBottomView.bounds;
    frame.size.width = _progress * _firstBottomView.bounds.size.width;
    _maskLayer.frame = frame;
    
    _progress += 0.01;
}

- (void)updateColor:(NSTimer *)timer{
    
    [self updateColorForLayer:_gradientLayerForSecondBtmView];
}

- (void)updateColorForLayer:(CAGradientLayer *)layer{
    
    NSMutableArray *originArr = [_gradientLayerForSecondBtmView.colors mutableCopy];
    
    //retain the last object
    id lastColor = originArr.lastObject;
    
    //remove the last object in the arr
    [originArr removeLastObject];
    
    //insert the last object at the first
    [originArr insertObject:lastColor atIndex:0];
    
    NSArray *updateArr = originArr.copy;
    _gradientLayerForSecondBtmView.colors = updateArr;
    
    //configure animation for the colors property
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.toValue = updateArr;
    animation.duration = 0.1;
    [_gradientLayerForSecondBtmView addAnimation:animation forKey:nil];
}


#pragma mark - configure colors property for layer
- (void)setupLayer:(CAGradientLayer *)layer{
    
    layer.startPoint = CGPointMake(0, 0.5);
    layer.endPoint = CGPointMake(1, 0.5);
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 400; i+=5) {

        UIColor *color = [UIColor colorWithHue:1.0 * i / 400 saturation:1 brightness:1 alpha:1];
        [arr addObject:(id)color.CGColor];
    }
    
    layer.colors = [arr copy];
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

//
//  MaskNextViewController.m
//  AnimationDemo
//
//  Created by lotus on 2017/12/1.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import "MaskNextViewController.h"

@interface MaskNextViewController ()

@property (weak, nonatomic) IBOutlet UIView *labelBgView;
@property (weak, nonatomic) IBOutlet UIView *imageBgView_1;
@property (weak, nonatomic) IBOutlet UIView *imageBgView_2;

@end

@implementation MaskNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self configureLayerForLabelBgView];
    [self configureLayerForImageBgView_1];
    [self configureLayerForImageBgView_2];
}

- (void)configureLayerForLabelBgView{
    
    //add gradient layer to label bg view
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = _labelBgView.bounds;
    [self setupGradientlayer:gradientLayer];

    [_labelBgView.layer addSublayer:gradientLayer];
    
    //add label to label bg view
    UILabel *label = [[UILabel alloc] initWithFrame:_labelBgView.bounds];

    //remember to set the bg color's alpha to 0
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"天王老子天下无敌";
    label.font = [UIFont systemFontOfSize:30];
    [_labelBgView addSubview:label];

    gradientLayer.mask = label.layer;
    
}

- (void)configureLayerForImageBgView_1{
    //add gradient layer to ImageBgView_1
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = _imageBgView_1.bounds;
    [self setupGradientlayer:gradientLayer];
    [_imageBgView_1.layer addSublayer:gradientLayer];
    
    //add imageview to imageBgView_1
    UIImageView *imgView = [self imageViewWithframe:CGRectMake(10, 10, _imageBgView_1.bounds.size.width-20, _imageBgView_1.bounds.size.height-20) image:@"bgTransparent"];
    [_imageBgView_1 addSubview:imgView];
    
    _imageBgView_1.layer.mask = imgView.layer;
}

- (void)configureLayerForImageBgView_2{
    //add gradient layer to ImageBgView_2
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = _imageBgView_1.bounds;
//    [self setupGradientlayer:gradientLayer];
//    [_imageBgView_2.layer addSublayer:gradientLayer];
    
    //add imageview to imageBgView_1
    UIImageView *imgView = [self imageViewWithframe:_imageBgView_2.bounds image:@"bgTransparent"];
    [_imageBgView_2 addSubview:imgView];
    
//    _imageBgView_2.layer.mask = imgView.layer;
}

#pragma mark - settup layer method
- (void)setupGradientlayer:(CAGradientLayer *)layer{
    
    //configure gradient colors
    NSMutableArray *tmpArr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 400; i += 5) {
        UIColor *color  = [UIColor colorWithHue:1.0 * i / 400 saturation:1 brightness:1 alpha:1];
        [tmpArr addObject:(id)color.CGColor];
    }
    
    layer.colors = tmpArr.copy;
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 1);
}

- (UIImageView *)imageViewWithframe:(CGRect)rect image:(NSString *)imageName{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.image = [UIImage imageNamed:imageName];
    return imgView;
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

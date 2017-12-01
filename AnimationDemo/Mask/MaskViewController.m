//
//  MaskViewController.m
//  AnimationDemo
//
//  Created by lotus on 2017/11/30.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import "MaskViewController.h"
#import "MaskNextViewController.h"

static NSInteger const space = 10;

@interface MaskViewController ()
{
    CALayer *_firstLayer;
    CALayer *_topLayer;
    CALayer *_middleLayer;
    CALayer *_btmLayer;
    CAGradientLayer *_gradientLayer;
}

@property (weak, nonatomic) IBOutlet UIImageView *firstImageview;
@property (weak, nonatomic) IBOutlet UIImageView *topImageview;
@property (weak, nonatomic) IBOutlet UIImageView *middleImageview;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageview;



@end

@implementation MaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    [self configureTransparentLayer];
    [self configureNonTransparentLayer];
    [self configureCompositeMaskLayer];
    [self configureUndefinedMaskLayer];
}

- (void)viewDidLayoutSubviews{
    
    
    [super viewDidLayoutSubviews];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self resizeFrame];
    
}

- (void)initViews{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextVC)];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - event methods
- (void)nextVC{
    MaskNextViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MaskNextViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)configureTransparentLayer{
    
    //init mask layer
    _firstLayer = [CALayer layer];
    _firstLayer.frame = CGRectMake(30, 30, _firstLayer.bounds.size.width - 30 * 2, _firstLayer.bounds.size.height - 30 * 2);
    _firstLayer.contents = (id)[UIImage imageNamed:@"bgTransparent"].CGImage;
    _firstLayer.contentsGravity = kCAGravityResizeAspect;
    _firstLayer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.0].CGColor;
    
    //or u can init the bg color with clearColor, its appha is 0.
//    _firstLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    //add layer to imageview
    _firstImageview.layer.mask = _firstLayer;
}

- (void)configureNonTransparentLayer{
    
    //init mask layer
    _topLayer = [CALayer layer];
    _topLayer.frame = CGRectMake(30, 30, _topImageview.bounds.size.width - 30 * 2, _topImageview.bounds.size.height - 30 * 2);
    _topLayer.contents = (id)[UIImage imageNamed:@"bgTransparent"].CGImage;
    _topLayer.contentsGravity = kCAGravityResizeAspect;
    _topLayer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
    
    //add layer to imageview
    _topImageview.layer.mask = _topLayer;
}

- (void)configureCompositeMaskLayer{
    
    //init mask layer
    _middleLayer = [CALayer layer];
    _middleLayer.frame = CGRectMake(30, 30, _middleImageview.bounds.size.width - 30 * 2, _middleImageview.bounds.size.height - 30 * 2);
    _middleLayer.contents = (id)[UIImage imageNamed:@"bgNonTransparent"].CGImage;
    _middleLayer.contentsGravity = kCAGravityResizeAspect;
    _middleLayer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5].CGColor;
    
    //add layer to imageview
    _middleImageview.layer.mask = _middleLayer;
}


- (void)configureUndefinedMaskLayer{
    
    //add gradient layer to imageview layer
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.frame =  _bottomImageview.bounds;
    [self setupGradientlayer:_gradientLayer];
    [_bottomImageview.layer addSublayer:_gradientLayer];
    
    //init mask layer
    _btmLayer = [CALayer layer];
    _btmLayer.frame = CGRectMake(30, 30, _bottomImageview.bounds.size.width - 30 * 2, _bottomImageview.bounds.size.height - 30 * 2);
    _btmLayer.contents = (id)[UIImage imageNamed:@"bgTransparent"].CGImage;
    _btmLayer.contentsGravity = kCAGravityResizeAspect;
    _btmLayer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5].CGColor;
    
    _gradientLayer.mask = _btmLayer;
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
    
    //configure gradient direction
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 1);
}

- (void)resizeFrame{

    _gradientLayer.frame =  _bottomImageview.bounds;
    _firstLayer.frame = CGRectMake(space, space, _firstImageview.bounds.size.width - space * 2, _firstImageview.bounds.size.height - space * 2);
    _topLayer.frame = CGRectMake(space, space, _topImageview.bounds.size.width - space * 2, _topImageview.bounds.size.height - space * 2);
    _middleLayer.frame = CGRectMake(space, space, _middleImageview.bounds.size.width - space * 2, _middleImageview.bounds.size.height - space * 2);
    _btmLayer.frame = CGRectMake(space, space, _bottomImageview.bounds.size.width - space * 2, _bottomImageview.bounds.size.height - space * 2);
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

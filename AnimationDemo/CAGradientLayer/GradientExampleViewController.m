//
//  GradientExampleViewController.m
//  AnimationDemo
//
//  Created by lotus on 2017/11/29.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import "GradientExampleViewController.h"
#import "GradientViewController.h"

@interface GradientExampleViewController ()
{
    CAGradientLayer *_gradientLayer;
}
@property (weak, nonatomic) IBOutlet UIView *myVIew;
@end

@implementation GradientExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    [self configureLayerForMyView];
}

- (void)initViews{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextVC)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    _gradientLayer.frame = _myVIew.bounds;
}

#pragma mark - event methods
- (void)nextVC{
    GradientViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GradientViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)configureLayerForMyView{
    
    _gradientLayer = [CAGradientLayer layer];
    
    _gradientLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor yellowColor].CGColor/*, (id)[UIColor redColor].CGColor*/];
    _gradientLayer.locations = @[@(0.4  ), @(0.5)];
    _gradientLayer.startPoint = CGPointMake(0, 0.0);//0
    _gradientLayer.endPoint = CGPointMake(0, 0.7);//0.7
    [_myVIew.layer addSublayer:_gradientLayer];
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

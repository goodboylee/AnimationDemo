//
//  ShaperViewController.m
//  AnimationDemo
//
//  Created by lotus on 2017/11/27.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import "ShaperViewController.h"

//views
#import "DiagramView.h"

@interface ShaperViewController ()


@property (weak, nonatomic) IBOutlet DiagramView *diagramView;
@end

@implementation ShaperViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)btnAction:(UIButton *)sender {
    
//    [_diagramView addDiagram:YES];
    NSInteger tag = sender.tag;
    if (tag == 0) {
        [_diagramView addDiagram:YES];
    }else{
        [_diagramView addDiagram_1:YES];
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

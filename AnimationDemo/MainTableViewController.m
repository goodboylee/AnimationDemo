//
//  MainTableViewController.m
//  AnimationDemo
//
//  Created by lotus on 2017/10/26.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import "MainTableViewController.h"
#import "AnimationViewController.h"
#import "ShaperViewController.h"
#import "GradientExampleViewController.h"
#import "MaskViewController.h"
#import "MaskViewController.h"
#import "EmitterListTableViewController.h"
#import "ReplicatorLIstTableViewController.h"


static NSString *const cellIdentifier = @"cellIdentifier";

@interface MainTableViewController ()

@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self initData];
    
}

- (void)initData{
    self.dataSource = @[@"基础动画", @"CAShaperLayer USE", @"CAGradientLayer USE", @"Mask使用", @"Emitter List", @"CAReplicatorLayer USE"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        [self pushToBasicAnimationVC];
    }else if (indexPath.row == 1){
        [self pushToShaperVC];
    }else if (indexPath.row == 2){
        [self pushToGradientVC];
    }else if (indexPath.row == 3){
        [self pushToMaskVC];
    }else if (indexPath.row == 4){
        [self pushToEmitterList];
    }else if (indexPath.row == 5){
        [self pushToReplicatorListVC];
    }
        
}


#pragma mark - private methods
- (void)pushToBasicAnimationVC{
    AnimationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AnimationViewController"];
    
    //转场动画
    CATransition *transition = [CATransition animation];
    
    //切换其他值试下效果
    transition.type = kCATransitionFade;
    
    //打开这个玩玩
    //    transition.subtype = kCATransitionFromTop;
    transition.duration = 0.25;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)pushToShaperVC{
    ShaperViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ShaperViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushToGradientVC{
    GradientExampleViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"GradientExampleViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)pushToMaskVC{
    MaskViewController *maskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MaskViewController"];
    [self.navigationController pushViewController:maskVC animated:YES];
}
- (void)pushToEmitterList{
    EmitterListTableViewController *vc  =[self.storyboard instantiateViewControllerWithIdentifier:@"EmitterListTableViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)pushToReplicatorListVC{
    ReplicatorLIstTableViewController *vc = [[ReplicatorLIstTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/





@end

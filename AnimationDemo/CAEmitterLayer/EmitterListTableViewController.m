//
//  EmitterListTableViewController.m
//  AnimationDemo
//
//  Created by lotus on 2017/12/4.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import "EmitterListTableViewController.h"
#import "EmitterDetailViewController.h"
#import "EmitterTestViewController.h"

static NSString *const cellID = @"cellID";

@interface EmitterListTableViewController ()
{
    NSArray *_datas;
}
@end

@implementation EmitterListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
}

- (void)initData{
    _datas = @[@"火焰效果", @"雪花效果", @"烟花效果", @"test"];
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

    return _datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = _datas[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    if (row == 0) {
        [self pushToDetailVCWithType:EmitterTypeFire];
    }else if (row == 1){
        [self pushToDetailVCWithType:EmitterTypeSnow];
    }else if (row == 2){
        [self pushToDetailVCWithType:EmitterTypeSparkle];
    }
    
    else{
        [self pushToTestVC];
    }
}

- (void)pushToDetailVCWithType:(EmitterType)type{
    EmitterDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EmitterDetailViewController"];
    vc.emitterType = type;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)pushToTestVC{
    EmitterTestViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EmitterTestViewController"];
    [self.navigationController pushViewController:vc animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

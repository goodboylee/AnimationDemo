//
//  ReplicatorViewController.h
//  AnimationDemo
//
//  Created by Lotus on 2017/12/6.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RpUse){
    RpUseAnimation,
    RpUseTransform,
    RpUseSubRp
};

@interface ReplicatorViewController : UIViewController

@property (nonatomic, assign) RpUse useType;

@end

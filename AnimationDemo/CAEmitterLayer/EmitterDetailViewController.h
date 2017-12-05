//
//  EmitterDetailViewController.h
//  AnimationDemo
//
//  Created by lotus on 2017/12/5.
//  Copyright © 2017年 李灿荣. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, EmitterType){
    EmitterTypeFire = 1,
    EmitterTypeSnow,
    EmitterTypeSparkle
};

@interface EmitterDetailViewController : UIViewController

@property (nonatomic, assign) EmitterType emitterType;
@end

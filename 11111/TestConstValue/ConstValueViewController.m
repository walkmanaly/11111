//
//  ConstValueViewController.m
//  11111
//
//  Created by Nick on 2018/7/23.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "ConstValueViewController.h"

NSString *const ConstValueViewControllerNotification = @"ConstValueViewControllerNotification";

// 用static const 在实现文件声明不变常亮，替代#define预处理命令
static const NSTimeInterval kAnimationDuration = 0.5;
static const NSString *kIdentifier = @"reusecell";

@interface ConstValueViewController ()

@end

@implementation ConstValueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:ConstValueViewControllerNotification object:nil];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ConstValueViewController.m
//  11111
//
//  Created by Nick on 2018/7/23.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "ConstValueViewController.h"



NSString *const ConstValueViewControllerNotification = @"ConstValueViewControllerNotification";

// 用static const 在实现文件声明不变常量，替代#define预处理命令
static const NSTimeInterval kAnimationDuration = 2;
static const NSString *kIdentifier = @"reusecell";

@interface ConstValueViewController ()

@end

@implementation ConstValueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:ConstValueViewControllerNotification object:nil];
    });
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 100, 100)];
    v.backgroundColor = [UIColor blueColor];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        v.backgroundColor = [UIColor whiteColor];
    }];
    [self.view addSubview:v];
}

NSString *NSSringForMechinState(HGMMechinState state) {
    switch (state) {
        case HGMMechinStateNormal:
            return @"normal";
            break;
            
        case HGMMechinStateSelected:
            return @"selected";
            break;
            
        case HGMMechinStateDisable:
            return @"disable";
            break;
            
        default:
            return nil;
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

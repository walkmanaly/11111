//
//  ConstValueViewController.h
//  11111
//
//  Created by Nick on 2018/7/23.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <UIKit/UIKit.h>

// 用extern 在头文件定义外部可访问的固定常量，在前面带上类名信息ConstValueViewController防止重复
extern NSString *const ConstValueViewControllerNotification;
extern NSString *const onstValueViewControllerCellIdentifier;

@interface ConstValueViewController : UIViewController

@end

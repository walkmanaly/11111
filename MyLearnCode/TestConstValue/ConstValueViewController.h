//
//  ConstValueViewController.h
//  11111
//
//  Created by Nick on 2018/7/23.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <UIKit/UIKit.h>
// extern告诉编译器，在全局符号表中将会有一个名叫ConstValueViewControllerNotification的符号。
// 此常量必须要定义，而且只能定义一次。在头文件中声明，在实现文件中定义。
// 用extern 在头文件定义外部可访问的固定常量，在前面带上类名信息ConstValueViewController防止重复
extern NSString *const ConstValueViewControllerNotification;
extern NSString *const onstValueViewControllerCellIdentifier;

typedef NS_ENUM(NSUInteger, HGMMechinState) {
    HGMMechinStateNormal,
    HGMMechinStateSelected,
    HGMMechinStateDisable,
};

extern NSString *NSSringForMechinState(HGMMechinState state);

@interface ConstValueViewController : UIViewController

@end

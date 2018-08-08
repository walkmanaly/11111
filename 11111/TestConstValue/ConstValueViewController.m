//
//  ConstValueViewController.m
//  11111
//
//  Created by Nick on 2018/7/23.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "ConstValueViewController.h"

/*
 duplicate symbol _kDefaultHeight in:
 /Users/Nick/Library/Developer/Xcode/DerivedData/11111-aqvpzgmfnahlssdrcifacmovdgka/Build/Intermediates.noindex/11111.build/Debug-iphonesimulator/11111.build/Objects-normal/x86_64/HGMConstValueView.o
 /Users/Nick/Library/Developer/Xcode/DerivedData/11111-aqvpzgmfnahlssdrcifacmovdgka/Build/Intermediates.noindex/11111.build/Debug-iphonesimulator/11111.build/Objects-normal/x86_64/ConstValueViewController.o
 ld: 1 duplicate symbol for architecture x86_64
 
 编译单元：指每个类的实现文件.m
 如果不用static修饰，编译器会为它创建一个外部符号。如果另个编译单元也声明了同样同名的变量，那么编译器就会抛出上面的错误信息。
 所以在 kDefaultHeight 前加static
 static：修饰符，意味着仅在定义此变量的编译单元中可见。
 
 */
static const NSString *kDefaultHeight;

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

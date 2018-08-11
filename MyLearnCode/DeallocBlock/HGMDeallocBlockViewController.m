//
//  HGMDeallocBlockViewController.m
//  11111
//
//  Created by Nick on 2018/8/6.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMDeallocBlockViewController.h"
#import "NSObject+HGMGuard.h"

@interface HGMDeallocBlockViewController ()

@end

@implementation HGMDeallocBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 在对象销毁时调用
    [self addGuardDeallocBlock:^{
        NSLog(@"deadalloc dosometing");
    }];
    [self addGuardDeallocBlock:^{
        NSLog(@"deadalloc dosometing twice");
    }];
    [self addGuardDeallocBlock:^{
        NSLog(@"deadalloc dosometing third");
    }];
}



@end

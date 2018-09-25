//
//  HGMBlockViewController.m
//  MyLearnCode
//
//  Created by Nick on 2018/9/25.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMBlockViewController.h"

typedef void (^Block)(void);

void (^block)(void);

@interface HGMBlockViewController ()

@end

@implementation HGMBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    Block block = [self test];
//    block();
    
    
//        [self stackBlock];
//        block();
    
}

- (Block)test {
    int a = 10;
    Block block = ^ {
        NSLog(@"-----------%d", a);
    };
    NSLog(@"-----------%@", [block class]);
    return block;
}

- (void)stackBlock {
    int b = 20;
    block = ^ {
        NSLog(@"=======%d", b);
    };
    NSLog(@"======%@", [block class]);
}

@end

//
//  HGMClassClusterViewController.m
//  MyLearnCode
//
//  Created by Nick on 2018/8/27.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMClassClusterViewController.h"

@interface HGMClassClusterViewController ()

@end

@implementation HGMClassClusterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testClassCluster];
}

- (void)testClassCluster {
    // 根据传入的type创建按钮，系统实现可能是创建UIButton的子类实例返回的
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    NSLog(@"%d", [button1 isMemberOfClass:[UIButton class]]);
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeInfoDark];
    NSLog(@"%d", [button2 isMemberOfClass:[UIButton class]]);
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    NSLog(@"%d", [button3 isMemberOfClass:[UIButton class]]);
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeSystem];
    NSLog(@"%d", [button4 isMemberOfClass:[UIButton class]]);
}


@end

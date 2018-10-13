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
    [self testFatoryMode];
}

- (void)testFatoryMode {
    NSArray *array = [NSArray array];
    NSMutableArray *mutArray = [NSMutableArray array];
    NSLog(@"array = %@, mutArray = %@", [array class], [mutArray class]);
    // array = __NSArray0, mutArray = __NSArrayM
    
    NSDictionary *dict = [NSDictionary dictionary];
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
    NSLog(@"dict = %@, mutDict = %@", [dict class], [mutDict class]);
    // dict = __NSDictionary0, mutDict = __NSDictionaryM
    
    NSSet *set = [NSSet set];
    NSMutableSet *mutSet = [NSMutableSet set];
    NSLog(@"set = %@, mutSet = %@", [set class], [mutSet class]);
    // set = __NSSetI, mutSet = __NSSetM
    
    // NSArray使用工厂模式，创建实例的时候，内部实现是创建NSArray的子类的实例
    // 在cocoa框架中，colletion类型的类都是这样实现。
}

- (void)testClassCluster {
    // 根据传入的type创建按钮，系统实现可能是创建UIButton的子类实例返回的
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeContactAdd];
    NSLog(@"%@", [button1 class]);
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeInfoDark];
    NSLog(@"%@", [button2 class]);
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    NSLog(@"%@", [button3 class]);
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeSystem];
    NSLog(@"%@", [button4 class]);}


@end

//
//  OneViewController.m
//  11111
//
//  Created by Nick on 2018/7/10.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"

#import "TestRecycleReferanceObjectA.h"
#import "TestRecycleReferanceObjectB.h"

#import <objc/runtime.h>

typedef void(^testBlock)(void);

@interface OneViewController ()

@property (nonatomic, copy) testBlock testB;
@property (nonatomic, copy) NSString *testStr;

@property (nonatomic, strong) TestRecycleReferanceObjectA *a;
@property (nonatomic, strong) TestRecycleReferanceObjectB *b;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self testRecycleReferance1];
    
}

- (void)testRecycleReferance1 {
    self.a = [[TestRecycleReferanceObjectA alloc] init];
    self.b = [[TestRecycleReferanceObjectB alloc] init];
    
    self.a.objB = self.b;
    self.b.objA = self.a;
    unsigned int outcount = 0;
    Ivar *ivars = class_copyIvarList([TestRecycleReferanceObjectA class], &outcount);
    for (int i = 0; i < outcount; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"ivarName====%s", ivar_getName(ivar));
    }
}

- (void)testRecycleReferance {
    if (self.sendTextBlock) {
        self.sendTextBlock(@"text");
    }
    
    __weak typeof(self) weakSelf = self;
    self.testB = ^{
        NSString *strr = weakSelf.testStr;
        NSLog(@"%@", strr);
    };
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TwoViewController *vc = [[TwoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end

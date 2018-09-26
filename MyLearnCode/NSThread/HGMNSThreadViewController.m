
//
//  HGMNSThreadViewController.m
//  MyLearnCode
//
//  Created by Nick on 2018/9/26.
//  Copyright © 2018 nick. All rights reserved.
//

#import "HGMNSThreadViewController.h"

@interface HGMNSThreadViewController ()

@end

@implementation HGMNSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self nsthread1];
}

- (void)nsthread1 {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(task1) object:nil];
    [thread start];
}

- (void)task1 {
    NSLog(@"task1---%@", [NSThread currentThread]);
}

@end

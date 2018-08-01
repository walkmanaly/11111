//
//  HGMPartimeViewController.m
//  11111
//
//  Created by Nick on 2018/8/1.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMPartimeViewController.h"
#import "HGMEmployer.h"

@interface HGMPartimeViewController () <HGMEmployerDelegate>

@end

@implementation HGMPartimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatEmployer];
}

- (void)creatEmployer {
    HGMEmployer *employer = [[HGMEmployer alloc] init];
    employer.delegate = self;
    [employer callDelegate];
}

- (void)employerHireMembers {
    NSLog(@"employerHireMembers");
}

@end

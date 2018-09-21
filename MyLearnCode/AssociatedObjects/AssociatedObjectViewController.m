//
//  AssociatedObjectViewController.m
//  11111
//
//  Created by Nick on 2018/7/24.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "AssociatedObjectViewController.h"
#import "NSObject+AssociatedObjects.h"
#import "UIView+HGMAssociateView.h"

@interface AssociatedObjectViewController () <AssociatedObjectsProtocol, AssociateViewProtocol>

@end

@implementation AssociatedObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSObject *obj = [[NSObject alloc] init];
//    obj.delegate = self;
//    obj.associatedObject = @"hello";
//
//    NSLog(@"%@", obj.associatedObject);
//    [obj associatiedMethod];
//
    UIView *view = [[UIView alloc] init];
    view.desc = @"description";
    view.delegate = self;
    NSLog(@"%@", view.desc);
    [self.view addSubview:view];
    [view removeFromSuperview];
}

#pragma mark - AssociatedObjectsProtocol
- (void)associatedObjectsProtocolMethod {
    NSLog(@"associatedObjectsProtocolMethod");
}

#pragma mark - AssociateViewProtocol
- (void)test {
    NSLog(@"AssociateViewProtocol");
}

@end

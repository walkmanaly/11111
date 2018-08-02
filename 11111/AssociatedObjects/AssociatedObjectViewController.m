//
//  AssociatedObjectViewController.m
//  11111
//
//  Created by Nick on 2018/7/24.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "AssociatedObjectViewController.h"
#import "NSObject+AssociatedObjects.h"

@interface AssociatedObjectViewController () <AssociatedObjectsProtocol>

@end

@implementation AssociatedObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSObject *obj = [[NSObject alloc] init];
    obj.delegate = self;
    obj.associatedObject = @"hello";
    
    NSLog(@"%@", obj.associatedObject);
    [obj associatiedMethod];
    
}

#pragma mark - AssociatedObjectsProtocol
- (void)associatedObjectsProtocolMethod {
    NSLog(@"associatedObjectsProtocolMethod");
}



@end

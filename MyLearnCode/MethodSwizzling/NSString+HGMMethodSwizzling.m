//
//  NSString+HGMMethodSwizzling.m
//  11111
//
//  Created by Nick on 2018/7/26.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "NSString+HGMMethodSwizzling.h"
#import <objc/runtime.h>

@implementation NSString (HGMMethodSwizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        Method originMethod = class_getInstanceMethod(class, @selector(uppercaseString));
        Method exchangeMethod = class_getInstanceMethod(class, @selector(hgm_uppercaseString));
        method_exchangeImplementations(originMethod, exchangeMethod);
    });
}

- (void)hgm_uppercaseString {
    [self hgm_uppercaseString];
    NSLog(@"call my uppercaseString");
}

@end

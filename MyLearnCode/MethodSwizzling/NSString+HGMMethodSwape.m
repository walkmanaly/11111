//
//  NSString+HGMMethodSwape.m
//  11111
//
//  Created by Nick on 2018/8/12.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "NSString+HGMMethodSwape.h"
#import <objc/runtime.h>

@implementation NSString (HGMMethodSwape)

/*
 -------------------用FMDB的时候，引发crash-------------------------------------
 -------------------所以matt建议methodswizzling用于调试，谨慎用于业务开发-----------
 */

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method originMethod = class_getInstanceMethod([self class], @selector(lowercaseString));
//        Method swapeMethod = class_getInstanceMethod([self class], @selector(hgm_lowercaseString));
//        method_exchangeImplementations(originMethod, swapeMethod);
//    });
//}
//
//- (void)hgm_lowercaseString {
//    [self hgm_lowercaseString];
//    NSLog(@"call my lowercaseString");
//}

@end

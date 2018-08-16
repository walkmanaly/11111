//
//  HGMTestStaticLibrary.m
//  MyLearnCode
//
//  Created by Nick on 2018/8/16.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMTestStaticLibrary.h"
#import "HGMTool.h"

@implementation HGMTestStaticLibrary

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[[HGMTool alloc] init] stringWithNSInteger:2];
    }
    return self;
}

@end

//
//  NSObject+HGMGuard.m
//  11111
//
//  Created by Nick on 2018/8/6.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "NSObject+HGMGuard.h"
#import <objc/runtime.h>

//typedef <#returnType#>(^<#name#>)(<#arguments#>);

@interface Patasite : NSObject

@property (nonatomic, copy) void(^callbackBlock)(void);

@end

@implementation Patasite

- (void)dealloc {
    if (self.callbackBlock) {
        self.callbackBlock();
    }
}

@end

@implementation NSObject (HGMGuard)

// 为对象添加一个释放时执行的block
- (void)addGuardDeallocBlock:(void (^)(void))block {
    @synchronized (self) {
        static NSString *kAssosiatedKey = nil;
        id patasiteLists = objc_getAssociatedObject(self, &kAssosiatedKey);
        if (!patasiteLists) {
            patasiteLists = [NSMutableArray array];
            objc_setAssociatedObject(self, &kAssosiatedKey, patasiteLists, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
        Patasite *patasite = [[Patasite alloc] init];
        patasite.callbackBlock = block;
        [patasiteLists addObject:patasite];
    }
}

@end

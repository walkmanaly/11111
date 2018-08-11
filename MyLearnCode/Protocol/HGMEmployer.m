//
//  HGMEmployer.m
//  11111
//
//  Created by Nick on 2018/8/1.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMEmployer.h"

@interface HGMEmployer () {
    // bitfield------位段
    /*
     1表示一个二进制位，只能表示0或1两个值
     8表示八个二进制位，能表示0至255之间的值
     */
    // 此处只用做 委托者是否实现了某个代理方法 的缓存 (0或1就可以)
    struct {
        unsigned int shouldHireEmployee           :1;
        unsigned int shouldFireEmployee           :1;
        unsigned int shouldReplaceEmployee        :1;
    } _delegateFlags;
    
}



@end

@implementation HGMEmployer

- (instancetype)init {
    if (self = [super init]) {
        return self;
    }
    return nil;
}

// 如果委托者多次调用这些代理方法，那么这种缓存优化很有必要，提高程序性能
- (void)setDelegate:(id<HGMEmployerDelegate>)delegate {
    _delegate = delegate;
    _delegateFlags.shouldHireEmployee = [delegate respondsToSelector:@selector(employerShouldHireMembers)];
    _delegateFlags.shouldFireEmployee = [delegate respondsToSelector:@selector(employerShouldFireMembers)];
    _delegateFlags.shouldReplaceEmployee = [delegate respondsToSelector:@selector(employerShouldReplaceMembers)];
}

- (void)callDelegate {
    [self callDelegateDosomething];
}

- (void)callDelegateDosomething {
    // 委托者只调用一次
    if ([self.delegate respondsToSelector:@selector(employerHireMembers)]) {
        [self.delegate employerHireMembers];
    }
    
    if ([self.delegate respondsToSelector:@selector(employerFireMembers)]) {
        [self.delegate employerFireMembers];
    }
    
    if ([self.delegate respondsToSelector:@selector(employerReplaceMembers)]) {
        [self.delegate employerReplaceMembers];
    }
    
    // 委托者可能调用多次
    if (_delegateFlags.shouldHireEmployee) {
        [self.delegate employerShouldHireMembers];
    }
    
    if (_delegateFlags.shouldFireEmployee) {
        [self.delegate employerShouldFireMembers];
    }
    
    if (_delegateFlags.shouldReplaceEmployee) {
        [self.delegate employerShouldReplaceMembers];
    }
}

@end

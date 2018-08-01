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
        unsigned int didHireEmployee           :1;
        unsigned int didFireEmployee           :1;
        unsigned int didReplaceEmployee        :1;
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
    _delegateFlags.didHireEmployee = [delegate respondsToSelector:@selector(employerHireMembers)];
    _delegateFlags.didFireEmployee = [delegate respondsToSelector:@selector(employerFireMembers)];
    _delegateFlags.didReplaceEmployee = [delegate respondsToSelector:@selector(employerReplaceMembers)];
}

- (void)callDelegate {
    [self callDelegateDosomething];
}

- (void)callDelegateDosomething {
//    if ([self.delegate respondsToSelector:@selector(employerHireMembers)]) {
//        [self.delegate employerHireMembers];
//    }
    if (_delegateFlags.didHireEmployee) {
        [self.delegate employerHireMembers];
    }
    
    if (_delegateFlags.didFireEmployee) {
        [self.delegate employerFireMembers];
    }
    
    if (_delegateFlags.didReplaceEmployee) {
        [self.delegate employerReplaceMembers];
    }
}

@end

//
//  HGMEmployer.m
//  11111
//
//  Created by Nick on 2018/8/1.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMEmployer.h"

@implementation HGMEmployer

- (instancetype)init {
    if (self = [super init]) {
        return self;
    }
    return nil;
}

- (void)callDelegate {
    [self callDelegateDosomething];
}

- (void)callDelegateDosomething {
    if ([self.delegate respondsToSelector:@selector(employerHireMembers)]) {
        [self.delegate employerHireMembers];
    }
}

@end

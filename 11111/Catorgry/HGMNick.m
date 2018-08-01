//
//  HGMNick.m
//  11111
//
//  Created by Nick on 2018/8/2.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMNick.h"

@implementation HGMNick

- (instancetype)initWitnFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    if (self = [super init]) {
        self.firstName = firstName;
        self.lastName = lastName;
        return self;
    }
    return nil;
}

@end

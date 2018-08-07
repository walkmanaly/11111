//
//  HGMCopyingPerson.m
//  11111
//
//  Created by Nick on 2018/8/7.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMCopyingPerson.h"

@interface HGMCopyingPerson () {
    NSMutableSet *_friends;
}

@end

@implementation HGMCopyingPerson

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age {
    if (self = [super init]) {
        _name = name;
        _age = age;
        _friends = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)addFriend:(HGMCopyingPerson *)person {
    [_friends addObject:person];
}

- (void)removeFriend:(HGMCopyingPerson *)person {
    [_friends removeObject:person];
}

- (id)copyWithZone:(NSZone *)zone {
    HGMCopyingPerson *copy = [[[self class] allocWithZone:zone] initWithName:_name age:_age];
    copy->_friends = [_friends mutableCopy];
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    HGMCopyingPerson *mutableCopy = [[[self class] allocWithZone:zone] initWithName:_name age:_age];
    // copyItems为yes表示深拷贝，复制容器对象并且复制容器中的所有元素
    mutableCopy->_friends = [[NSMutableSet alloc] initWithSet:_friends copyItems:YES];
    return mutableCopy;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@-%@>", [self class], @{@"name": _name,
                                                                  @"age": @(_age),
                                                                  @"friends": _friends
                                                                  }];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@-%p-%@>", [self class], self, @{@"name": _name,
                                                                           @"age": @(_age),
                                                                           @"friends": _friends
                                                                           }];
}

@end

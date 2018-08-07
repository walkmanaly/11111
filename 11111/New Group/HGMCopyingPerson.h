//
//  HGMCopyingPerson.h
//  11111
//
//  Created by Nick on 2018/8/7.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <Foundation/Foundation.h>

// 如果一个类支持拷贝功能，就要遵循NSCopying或NSMutableCopying协议
// 并且分别实现这两个协议中的copyWithZone: 和mutableCopyWithZone: 方法
@interface HGMCopyingPerson : NSObject <NSCopying, NSMutableCopying>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age;

- (void)addFriend:(HGMCopyingPerson *)person;
- (void)removeFriend:(HGMCopyingPerson *)person;

@end

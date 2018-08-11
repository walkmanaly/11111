//
//  HGMKVOObject.m
//  11111
//
//  Created by Nick on 2018/8/2.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMKVOObject.h"

@implementation HGMKVOObject

- (void)setAge:(double)age
{
    NSLog(@"setAge:");
    _age = age;
}

- (void)setName:(NSString *)name {
    NSLog(@"setName:");
    _name = name;
}

// 添加kvo之后才会调用---与NSKVONotifying__HGMKVOObject一起生成
- (void)willChangeValueForKey:(NSString *)key
{
    NSLog(@"willChangeValueForKey: - begin");
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey: - end");
}
// 添加kvo之后才会调用
- (void)didChangeValueForKey:(NSString *)key
{
    NSLog(@"didChangeValueForKey: - begin");
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey: - end");
}


@end

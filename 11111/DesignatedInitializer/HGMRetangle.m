//
//  HGMRetangle.m
//  11111
//
//  Created by Nick on 2018/8/5.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMRetangle.h"

@implementation HGMRetangle

- (instancetype)initWithWidth:(double)width height:(double)height {
    if (self = [super init]) {
        _width = width;
        _height = height;
    }
    return self;
}

// 覆写父类的init方法
// 外界在调用初始化方法的时候，默认调用上面的designated方法，获得有默认值的实例。
- (instancetype)init {
    return [self initWithWidth:10.0 height:5.0];
}

@end

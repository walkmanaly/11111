//
//  HGMSquier.m
//  11111
//
//  Created by Nick on 2018/8/5.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMSquier.h"

@implementation HGMSquier

- (instancetype)initWithDemention:(double)demention {
    return [super initWithWidth:demention height:demention];
}

// 此处应该覆写父类的init方法
// 否则会调用父类的init方法，生成的是具有默认值的长方形而不是正方形了。
- (instancetype)init {
    return [self initWithDemention:10.0];
}

@end

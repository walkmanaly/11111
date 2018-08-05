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

// ------------------------1----------------------
// 此处应该覆写父类的init方法
// 否则会调用父类的init方法，生成的是具有默认值的长方形而不是正方形了。
//- (instancetype)init {
//    return [self initWithDemention:10.0];
//}

// ------------------------2-------------------------
// 或者覆写父类的designated initializer方法
- (instancetype)initWithWidth:(double)width height:(double)height {
    double demen = MAX(width, height);
    return [self initWithDemention:demen];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    // 需要调用父类的encode方法，不然父类的某些值并没有编码
    // 再编码本类的值
    // 这样才算完全遵循NSCoding协议(fully NSCoding compliant)
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_name forKey:@"name"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    // 此处需要调用父类的decoder方法去解码父类中的某些默认值
    // 再解码本类的值
    // 这样才算完全遵循NSCoding协议(fully NSCoding compliant)
    if (self = [super initWithCoder:aDecoder]) {
        _name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}


// 第17条
- (NSString *)description {
    // 以字符串打印---类的描述可能不需要指针和类型
    return [NSString stringWithFormat:@"\"%f %f %@\"", self.width, self.height, _name];
}

- (NSString *)debugDescription {
    // 以字典打印---在debug的时候可能需要知道指针和类型~
    return [NSString stringWithFormat:@"<%@:%p, \"%@\">", [self class], self, @{@"width": @(self.width),
                                                                                @"height": @(self.height),
                                                                                @"name": _name
                                                                                }];
}

@end

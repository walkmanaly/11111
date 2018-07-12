//
//  Product.m
//  11111
//
//  Created by Nick on 2018/7/12.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "Product.h"

@implementation Product

+ (instancetype)prductWithName:(NSString *)name price:(NSInteger)price date:(NSDate *)date {
    Product *p = [[Product alloc] init];
    p.name = name;
    p.price = price;
    p.date = date;
    return p;
}

@end

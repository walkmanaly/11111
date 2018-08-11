//
//  Product.h
//  11111
//
//  Created by Nick on 2018/7/12.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Product : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) float price;
@property (nonatomic, strong) NSDate *date;

+ (instancetype)prductWithName:(NSString *)name price:(NSInteger)price date:(NSDate *)date;

@end

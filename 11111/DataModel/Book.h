//
//  Book.h
//  11111
//
//  Created by Nick on 2018/7/12.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject <NSCoding>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) double pages;
@property (nonatomic, assign, getter = isAvilible) BOOL avilible;

@end

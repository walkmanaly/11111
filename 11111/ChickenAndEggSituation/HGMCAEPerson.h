//
//  HGMCAEPerson.h
//  11111
//
//  Created by Nick on 2018/8/8.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <Foundation/Foundation.h>

// HGMCAEPerson头文件引入HGMCAEEmployer，HGMCAEEmployer文件又引入HGMCAEPerson，导致“循环引用”
// 用优雅的方式解决：“向前声明”--@class

//#import "HGMCAEEmployer.h"
@class HGMCAEEmployer;

@interface HGMCAEPerson : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;

- (void)createEmployer:(HGMCAEEmployer *)employer;

@end

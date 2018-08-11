//
//  HGMCAEEmployer.h
//  11111
//
//  Created by Nick on 2018/8/8.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "HGMCAEPerson.h"
@class HGMCAEPerson;

@interface HGMCAEEmployer : NSObject

- (void)addEmployee:(HGMCAEPerson *)person;
- (void)removeEmployee:(HGMCAEPerson *)person;

@end

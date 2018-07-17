//
//  TestRecycleReferanceObjectA.h
//  11111
//
//  Created by Nick on 2018/7/17.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TestRecycleReferanceObjectB;

@interface TestRecycleReferanceObjectA : NSObject

@property (nonatomic, strong) TestRecycleReferanceObjectB *objB;

@end

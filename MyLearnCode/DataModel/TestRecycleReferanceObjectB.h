//
//  TestRecycleReferanceObjectB.h
//  11111
//
//  Created by Nick on 2018/7/17.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TestRecycleReferanceObjectA;
@interface TestRecycleReferanceObjectB : NSObject

@property (nonatomic, strong) TestRecycleReferanceObjectA *objA;

@property (nonatomic, assign, getter=isOn) BOOL on;

@end

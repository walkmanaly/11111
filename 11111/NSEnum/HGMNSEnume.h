//
//  HGMNSEnume.h
//  11111
//
//  Created by Nick on 2018/8/8.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HGMDerection) {
    HGMDerectionEast    = 0,
    HGMDerectionWest    = 1 << 0,
    HGMDerectionSouth   = 1 << 1,
    HGMDerectionNorth   = 1 << 2
};

@interface HGMNSEnume : NSObject

@property (nonatomic, assign) HGMDerection derection;
- (void)testEnume;

@end

//
//  HGMRetangle.h
//  11111
//
//  Created by Nick on 2018/8/5.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGMRetangle : NSObject

@property (nonatomic, assign, readonly) double width;
@property (nonatomic, assign, readonly) double height;

- (instancetype)initWithWidth:(double)width height:(double)height;

@end

NS_ASSUME_NONNULL_END

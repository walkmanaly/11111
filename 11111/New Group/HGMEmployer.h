//
//  HGMEmployer.h
//  11111
//
//  Created by Nick on 2018/8/1.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HGMEmployerProtocol <NSObject>

- (void)employerHireMembers;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HGMEmployer : NSObject

@property (nonatomic, weak) id<HGMEmployerProtocol> delegate;
- (void)callDelegate;

@end

NS_ASSUME_NONNULL_END

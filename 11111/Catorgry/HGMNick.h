//
//  HGMNick.h
//  11111
//
//  Created by Nick on 2018/8/2.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGMNick : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
- (instancetype)initWitnFirstName:(NSString *)firstName lastName:(NSString *)lastName;

@end

NS_ASSUME_NONNULL_END

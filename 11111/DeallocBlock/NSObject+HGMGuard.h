//
//  NSObject+HGMGuard.h
//  11111
//
//  Created by Nick on 2018/8/6.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//typedef <#returnType#>(^<#name#>)(<#arguments#>);

@interface NSObject (HGMGuard)

- (void)addGuardDeallocBlock:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END

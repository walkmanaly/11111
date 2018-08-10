//
//  HGMDES3Tool.h
//  11111
//
//  Created by Nick on 2018/8/10.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGMDES3Tool : NSObject

/**
 *  加密
 */
+ (NSString *)encrypt:(NSString *)plainText;

/**
 *  解密
 */
+ (NSString*)decrypt:(NSString*)encryptText;

@end

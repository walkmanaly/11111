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
 *
 *  @param plainText 明文
 *  @param key       密钥
 *  @param iv        向量
 *
 *  @return 密文
 */
+ (NSString *)AES256Encrypt:(NSString *)plainText key:(NSString *)key iv:(NSString *)iv;

@end

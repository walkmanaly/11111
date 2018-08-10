//
//  HGMDES3Tool.m
//  11111
//
//  Created by Nick on 2018/8/10.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMDES3Tool.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation HGMDES3Tool

/**
 *  加密
 *
 *  @param plainText 明文
 *  @param key       密钥
 *  @param iv        向量
 *
 *  @return 密文
 */
+ (NSString *)AES256Encrypt:(NSString *)plainText key:(NSString *)key iv:(NSString *)iv {
    
    char keyPtr[kCCKeySizeAES256+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          [key length],
                                          ivPtr,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return [resultData base64EncodedStringWithOptions:0];
    }
    free(buffer);
    return nil;
}

@end

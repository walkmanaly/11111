//
//  HGMDES3Tool.m
//  11111
//
//  Created by Nick on 2018/8/10.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMDES3Tool.h"
#import <CommonCrypto/CommonCryptor.h>

#define gkey            @"com.nick.haha"
#define gIv             @"hellonicky"

@implementation HGMDES3Tool

/**
 *  加密
 *
 *  @param plainText 明文
 *
 *  @return 密文
 */
+ (NSString *)enCrypt:(NSString *)plainText {
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    size_t movedBytes = 0;
    size_t bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    uint8_t *bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    const void *vkey = (const void *) [gkey UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    CCCryptorStatus ccStatus;
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    // 获得加密后的data
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    // 将加密后的data用base64加密转换成字符串
    NSString *result = [myData base64EncodedStringWithOptions:0];
    free(bufferPtr);
    return result;
}
/**
 *  解密
 *
 *  @param encryptText 密文
 *
 *  @return 明文
 */
+ (NSString*)deCrypt:(NSString *)encryptText {
    // 将密文用base64解密成密文data
    NSData* encryptData = [[NSData alloc] initWithBase64EncodedString:encryptText options:0];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    size_t movedBytes = 0;
    size_t bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    uint8_t *bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    const void *vkey = (const void *) [gkey UTF8String];
    const void *vinitVec = (const void *) [gIv UTF8String];
    // 按上面加密规则进行解密
    CCCryptorStatus ccStatus;
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    // 将解密后的data转换成string
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                      length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    free(bufferPtr);
    return result;
}

@end

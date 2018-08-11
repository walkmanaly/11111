//
//  HGMBridgeViewController.m
//  11111
//
//  Created by Nick on 2018/8/1.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMBridgeViewController.h"
#define BYTES_LENGTH 8

@interface HGMBridgeViewController ()

@end

@implementation HGMBridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bridgeCF2NS];
    [self bridgeNS2CF];
    
    [self bridgeTransferCF2NS];
    [self bridgeRetainedNS2CF];
}
// 只是为了让编译通过，其他毫无影响，最终还是需要手动调用 CFRelease(cfData) 来释放 cfData。
- (void)bridgeCF2NS {
    uint8_t bytes[BYTES_LENGTH] = {0x00};
    CFDataRef cfData = CFDataCreate(kCFAllocatorDefault, bytes, BYTES_LENGTH);
    NSData *nsData = (__bridge NSData *)cfData;
}
// 只是为了让编译通过，其他毫无影响。不需要手动调用 CFRelease(cfData) 来释放 cfData，因为对象的所有权没有改变，生命周期管理还是靠 ARC。
- (void)bridgeNS2CF {
    uint8_t bytes[BYTES_LENGTH] = {0x00};
    NSData *nsData = [NSData dataWithBytes:bytes length:BYTES_LENGTH];
    CFDataRef cfData = (__bridge CFDataRef)nsData;
}
// 等价于 CFBridgingRelease()，将 CF 对象转换为 OC 对象，并将所有权转移给 ARC。
- (void)bridgeTransferCF2NS {
    uint8_t bytes[BYTES_LENGTH] = {0x00};
    CFDataRef cfData = CFDataCreate(kCFAllocatorDefault, bytes, BYTES_LENGTH);
    NSData *nsData = (__bridge_transfer NSData *)cfData;
}
// 等价于 CFBridgingRetain()，用以将 OC 对象转换为 CF 对象，并且 Retain Count 立即 +1。
- (void)bridgeRetainedNS2CF {
    uint8_t bytes[BYTES_LENGTH] = {0x00};
    NSData *nsData = [NSData dataWithBytes:bytes length:BYTES_LENGTH];
    CFDataRef cfData = (__bridge_retained CFDataRef)nsData;
}

@end

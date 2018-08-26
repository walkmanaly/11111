//
//  HGMKeychainViewController.m
//  MyLearnCode
//
//  Created by Nick on 2018/8/26.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMKeychainViewController.h"
#import <SAMKeychain.h>
#import <SAMKeychainQuery.h>

static NSString *passwordService = @"com.nick.keychain";

@interface HGMKeychainViewController ()

@end

@implementation HGMKeychainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self keychain];
}


- (void)keychain {
    
    NSString *name = @"Nick";
    NSString *password = @"123456";
    
    BOOL flag = [SAMKeychain setPassword:password forService:passwordService account:name];
    
    if (flag) {
        // 保存到钥匙串成功
        NSLog(@"保存到钥匙串成功");
    } else {
        NSLog(@"保存到钥匙串失败");
    }
    
    NSString *getPassword = [SAMKeychain passwordForService:passwordService account:name];
    NSLog(@"getPassword===%@", getPassword);
    
}

@end

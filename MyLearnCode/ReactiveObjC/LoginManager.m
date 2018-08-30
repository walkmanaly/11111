//
//  LoginManager.m
//  MyLearnCode
//
//  Created by Nick on 2018/8/30.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "LoginManager.h"

@implementation LoginManager


+ (id)sharedManager
{
    static LoginManager *sharedManager = nil;
    static dispatch_once_t once = 0L;
    dispatch_once(&once, ^{
        sharedManager = [[LoginManager alloc] init];
    });
    return sharedManager;
}

- (void)logInWithUsername:(NSString *)name password:(NSString *)password {
    
}

@end

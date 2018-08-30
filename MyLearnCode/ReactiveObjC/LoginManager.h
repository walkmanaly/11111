//
//  LoginManager.h
//  MyLearnCode
//
//  Created by Nick on 2018/8/30.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginManager : NSObject

@property (class, readonly, strong) LoginManager *sharedManager;

- (void)logInWithUsername:(NSString *)name password:(NSString *)password;

@end

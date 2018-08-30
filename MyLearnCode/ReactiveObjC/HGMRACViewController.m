//
//  HGMRACViewController.m
//  MyLearnCode
//
//  Created by Nick on 2018/8/30.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMRACViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "LoginManager.h"

static NSString *UserDidLogOutNotification = @"UserDidLogOutNotification";

@interface HGMRACViewController ()

@property (nonatomic, strong) UIButton *logInButton;
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, assign) BOOL loggedIn;
@property (nonatomic, assign) BOOL loggingIn;

@end

@implementation HGMRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    @weakify(self);
//    
//    RAC(self.logInButton, enabled) = [RACSignal
//                                      combineLatest:@[
//                                                      self.usernameTextField.rac_textSignal,
//                                                      self.passwordTextField.rac_textSignal,
//                                                      RACObserve(LoginManager.sharedManager, loggingIn),
//                                                      RACObserve(self, loggedIn)
//                                                      ] reduce:^(NSString *username, NSString *password, NSNumber *loggingIn, NSNumber *loggedIn) {
//                                                          return @(username.length > 0 && password.length > 0 && !loggingIn.boolValue && !loggedIn.boolValue);
//                                                      }];
//    
//    [[self.logInButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
//        @strongify(self);
//        
//        RACSignal *loginSignal = [LoginManager.sharedManager
//                                  logInWithUsername:self.usernameTextField.text
//                                  password:self.passwordTextField.text];
//        
//        [loginSignal subscribeError:^(NSError *error) {
//            @strongify(self);
//            [self presentError:error];
//        } completed:^{
//            @strongify(self);
//            self.loggedIn = YES;
//        }];
//    }];
//    
//    RAC(self, loggedIn) = [[NSNotificationCenter.defaultCenter
//                            rac_addObserverForName:UserDidLogOutNotification object:nil]
//                           mapReplace:@NO];
//    
}

- (void)presentError:(NSError *)error {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  HGMJSDemoViewController.m
//  MyLearnCode
//
//  Created by Nick on 2018/9/19.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMJSDemoViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface HGMJSDemoViewController ()

@property (nonatomic, strong) JSContext *jscontext;

@end

@implementation HGMJSDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    //-----------------------------OC与js通讯-----------------------------
    
    // 要执⾏行行的 JS 代码，定义⼀一个 add 函数并执⾏行行
    NSString *addjs = @"function add(a, b) {return a + b;};add(1,3)";
    // sumValue 为执⾏行行后的结果
    JSValue *sumValue = [self.jscontext evaluateScript:addjs withSourceURL: [NSURL URLWithString:@"add.js"]];
    NSLog(@"sum: %@", @([sumValue toInt32])); // 4
    
    
    
    NSString *addjsa = @"function add(a, b) {return a + b;}";
    [self.jscontext evaluateScript:addjsa withSourceURL:[NSURL
                                                      URLWithString:@"add.js"]];
    JSValue *resultValue = [self.jscontext[@"add"] callWithArguments:@[@2, @4]];
    NSLog(@"Result: %@", @([resultValue toInt32])); // 6
    
    
    
    NSString *js = @"var name = \"Lefe_x\";var log_name = function(aname){var res = 'Hello ' + aname;console.log(res);};log_name(name);var age = 24;var sum_age = age + 1;";
    [self.jscontext evaluateScript:js withSourceURL:[NSURL
                                                     URLWithString:@"lefe.js"]];
    NSLog(@"%@", [self.jscontext[@"name"] toString]); // Lefe_x
    NSLog(@"%@", [self.jscontext[@"sum_age"] toString]); // 25
    
    
    // -----------------------------js与OC通讯-------------------------------
    
}

- (JSContext *)jscontext {
    if (!_jscontext) {
        _jscontext = [[JSContext alloc] init];
        _jscontext.name = @"com.nick.jscontex";
    }
    return _jscontext;
}

@end

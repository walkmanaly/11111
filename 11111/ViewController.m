//
//  ViewController.m
//  11111
//
//  Created by Nick on 2018/6/28.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "ViewController.h"
#import "HttpTools.h"
#import "Greeting.h"

#import "OneViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"hello world");

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [HttpTools getWithParams:@"?name=Nick" successed:^(NSDictionary *successed) {
//        NSLog(@"successed%@", successed);
//        Greeting *greet = [Greeting greetingWithId:successed[@"id"] content:successed[@"content"]];
//        NSLog(@"greet.id=%@, greet.content=%@", greet.id, greet.content);
//    } failured:^(NSString *failured) {
//        NSLog(@"failured%@", failured);
//    }];
    
//    [HttpTools getRequestWithSuccess:^(NSDictionary *successed) {
//
//    } failured:^(NSString *failured) {
//
//    }];

//    OneViewController *vc = [[OneViewController alloc] init];
//
//    [self.navigationController pushViewController:vc animated:YES];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op");
    }];
    
//    [op start];
    
    [queue addOperation:op];
    
    NSBlockOperation *clockOp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"clockOp");
    }];
    [queue addOperation:clockOp];
    
    [clockOp addDependency:op];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

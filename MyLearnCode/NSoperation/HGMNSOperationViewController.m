//
//  HGMNSOperationViewController.m
//  MyLearnCode
//
//  Created by Nick on 2018/9/25.
//  Copyright © 2018 nick. All rights reserved.
//

#import "HGMNSOperationViewController.h"
#import "HGMOperation.h"

@interface HGMNSOperationViewController ()

@end

@implementation HGMNSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 2
//    [self useNSBlockOperation];
    // 3
//    [self useAddExcuteoperation];
    // 4
//    [self useNSOperationSubClass];
    // 5
//    [self addOperationToQueue];
    // 7
    [self useDepandency];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 1
    // 在主线调用
    [self useNSInvocationOperation];
    
    // 在新线程中调用
    [NSThread detachNewThreadSelector:@selector(useNSInvocationOperation) toTarget:self withObject:nil];
}

// 1、 创建NSInvocationOperation对象，在当前线程中执行封装好的操作op。
- (void)useNSInvocationOperation {
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    [op start];
}

- (void)task1 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2];
        // 在主线程调用，打印主线程；在新线程调用，打印新线程
        NSLog(@"1---%@", [NSThread currentThread]);
    }
}

// 2、创建NSBlockOperation对象，直接跟上要执行的操作，在当前线程执行操作
- (void)useNSBlockOperation {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"===%@", [NSThread currentThread]);
        }
    }];
    [op start];
}

// 3、如果一个 NSBlockOperation 对象封装了多个操作。NSBlockOperation 是否开启新线程，取决于操作的个数。如果添加的操作的个数多，就会自动开启新线程。当然开启的线程数是由系统来决定的。
- (void)useAddExcuteoperation {
    // 1---<NSThread: 0x6000017f5980>{number = 3, name = (null)}
    // blockOperationWithBlock也不一定在主线程上执行
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"2---%@", [NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"3---%@", [NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"4---%@", [NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"5---%@", [NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"6---%@", [NSThread currentThread]);
        }
    }];
    
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"7---%@", [NSThread currentThread]);
        }
    }];
    
    [op start];
}

// 4、创建NSOperation的自定义子类

- (void)useNSOperationSubClass {
    HGMOperation *op = [[HGMOperation alloc] init];
    [op start];
}


//----------------------------------------------队列---------------------------------------

// 5、创建操作，添加到创建的队列中执行
// 自定义的队列
- (void)addOperationToQueue {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 6、控制最大并发数默认为-1，为1时：串行队列，大于1时：并发队列
    queue.maxConcurrentOperationCount = 1;      // 串行队列
    queue.maxConcurrentOperationCount = 2;      // 并发队列
    queue.maxConcurrentOperationCount = 6;      // 并发队列
    
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"2---%@", [NSThread currentThread]);
        }
    }];
    
    [op2 addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"3---%@", [NSThread currentThread]);
        }
    }];
    
    HGMOperation *op3 = [[HGMOperation alloc] init];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}

- (void)task2 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:1];
        NSLog(@"2---%@", [NSThread currentThread]);
    }
}

// 7、操作依赖
- (void)useDepandency {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    
    // 添加依赖，op2执行完op1才执行
    [op1 addDependency:op2];
}

@end

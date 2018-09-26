//
//  HGMGCDViewController.m
//  MyLearnCode
//
//  Created by Nick on 2018/9/26.
//  Copyright © 2018 nick. All rights reserved.
//

#import "HGMGCDViewController.h"

@interface HGMGCDViewController ()

@end

@implementation HGMGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 1
//    [self syncConcurrent];
    // 2
//    [self asyncConcurrent];
    // 3
//        [self syncSerial];
    // 4
//        [self asyncSerial];
    // 5
//    [self mainSync];
    // 5.1          -----创建新的线程，在新的线程中获取主线程添加任务执行-----
//    [NSThread detachNewThreadSelector:@selector(mainSync) toTarget:self withObject:nil];
    // 6
    [self mainAsync];
}

// 1、并发队列，同步执行
- (void)syncConcurrent {
    // 创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("com.nick.gm", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"syncConcurrent begin");
    // 添加同步任务1
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"1---%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    });
    // 添加同步任务2
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"2---%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    });
    // 添加同步任务3
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"3---%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    });
    NSLog(@"syncConcurrent end");
    // syncConcurrent begin -> 三个任务 ->syncConcurrent end
    // 结果：阻塞主线程，在主线程同步执行任务
}

// 并发队列，异步执行
- (void)asyncConcurrent {
    // 创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("com.nick.gm1", DISPATCH_QUEUE_CONCURRENT);
    // 全局队列，等同 创建的并发队列
//    dispatch_queue_t globleQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"asyncConcurrent begin");
    // 添加异步任务1
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"1===%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    });
    // 添加异步任务2
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"2===%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    });
    // 添加异步任务3
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"3===%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    });
    NSLog(@"asyncConcurrent end");
    // asyncConcurrent begin -> asyncConcurrent end 立即返回，不会卡主主线程。
    // 结果：开启三条子线程，并发执行任务
}

// 3、串行队列，同步执行
- (void)syncSerial {
    // 创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.nick.gm2", DISPATCH_QUEUE_SERIAL);
    NSLog(@"syncSerial begin");
    // 添加同步任务1
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"1---%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    });
    // 添加同步任务2
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"2---%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    });
    // 添加同步任务3
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"3---%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    });
    NSLog(@"syncSerial end");
    // 结果：在主线程，串行执行任务(同情况1)
}

// 4、创建串行队列，异步执行任务
- (void)asyncSerial {
    // 创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.nick.gm3", DISPATCH_QUEUE_SERIAL);
    NSLog(@"asyncSerial begin");
    // 添加异步任务1
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"1---%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    });
    // 添加异步任务2
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"2---%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    });
    // 添加异步任务3
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"3---%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    });
    
    NSLog(@"asyncSerial end");
    // asyncSerial begin -> asyncSerial end -> 执行三个任务
    // 结果：不会阻塞主线程，创建一条子线程，串行执行任务
}

// 5、主队列，同步执行******************************产生死锁
- (void)mainSync {
    dispatch_queue_t main = dispatch_get_main_queue();
    NSLog(@"mainSync begin");
    dispatch_sync(main, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"1===%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    });
    
    dispatch_sync(main, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"2===%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    });
    NSLog(@"mainSync end");
    // 结果：死锁，crash
    // 原因：主线程调用mainSync方法，此时又把任务添加到主队列；  mainSync在等添加的任务执行完才能继续
    //                                                  而添加的任务又在等mainSync执行完才能继续
}

// 6、主队列，异步执行
- (void)mainAsync {
    // 主队列
    dispatch_queue_t main = dispatch_get_main_queue();
    NSLog(@"mainAsync begin");
    // 添加异步任务1
    dispatch_async(main, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"1===%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    });
    // 添加异步任务2
    dispatch_async(main, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"2===%@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
        }
    });
    NSLog(@"mainAsync end");
    // 结果：按顺序在主线程同步执行任务
}

@end

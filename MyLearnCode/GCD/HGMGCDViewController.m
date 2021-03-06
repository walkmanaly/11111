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
//    [self mainAsync];
    // 7
//    [self threadCommunication];
    // 8
//    [self barrier];
    // 9
//    [self apply];
}

// 1、并发队列，同步执行
- (IBAction)syncConcurrent:(UIButton *)sender {
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

// 2、并发队列，异步执行----开启多条线程(系统决定)
- (IBAction)asyncConcurrent:(UIButton *)sender {
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
- (IBAction)syncSerial:(UIButton *)sender {
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

// 4、串行队列，异步执行----开启一条子线程串行执行任务()
- (IBAction)asyncSerial:(UIButton *)sender {
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
- (IBAction)mainSync:(UIButton *)sender {
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

// 5.1、解决死锁
- (IBAction)resolveDeadLock:(UIButton *)sender {
    //-----创建新的线程，在新的线程中获取主线程添加任务执行-----
    [NSThread detachNewThreadSelector:@selector(mainSync:) toTarget:self withObject:nil];
}


// 6、主队列，异步执行
- (IBAction)mainAsync:(UIButton *)sender {
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

// 7、线程间通讯
-(IBAction)threadCommunication:(UIButton *)sender {
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t main = dispatch_get_main_queue();
    
    dispatch_async(global, ^{
        // 往全局并发队列添加异步执行任务（耗时操作）
        NSLog(@"sleep 3s---%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:3];
        
        // 回到主队列，更新UI
        dispatch_async(main, ^{
            NSLog(@"update UI---%@", [NSThread currentThread]);
        });
    });
}

// 8、barrier
- (IBAction)barrier:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_queue_create("com.nick.gm8", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"task2 %@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"task1 %@", [NSThread currentThread]);
    });
    // 栅栏中的block操作在并发队列中，同一时间有且只有此任务执行。
    dispatch_barrier_async(queue, ^{
        
        [NSThread sleepForTimeInterval:2];
            NSLog(@"barrier %@", [NSThread currentThread]);
       
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"task4 %@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"task3 %@", [NSThread currentThread]);
    });
}

// 9、apply
- (IBAction)apply:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_queue_create("com.nick.gm9", DISPATCH_QUEUE_CONCURRENT);
    
//    NSArray *arr = @[@"a", @"b", @"c", @"d", @"e"];
    
    NSLog(@"apply begin");
    dispatch_apply(30, queue, ^(size_t index) {
        NSLog(@"%zu---%@", index, [NSThread currentThread]);
    });
    NSLog(@"apply end");
}

@end

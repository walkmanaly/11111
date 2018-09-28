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

@property (nonatomic, assign) NSInteger tiketsCount;
@property (nonatomic, strong) NSLock *lock;

@end

@implementation HGMNSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor grayColor];
    self.tiketsCount = 20;
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
//    [self useDepandency];
    // 8
//    [self usePriority];
    // 9
//    [self threadCommunication];
    // 10
//    [self buyTicket];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    // 1
//    // 在主线调用
//    [self useNSInvocationOperation:nil];
//    
//    // 在新线程中调用
//    [NSThread detachNewThreadSelector:@selector(useNSInvocationOperation:) toTarget:self withObject:nil];
//}

// 1、 创建NSInvocationOperation对象，在当前线程中执行封装好的操作op。
- (IBAction)useNSInvocationOperation:(UIButton *)sender {
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
- (IBAction)useNSBlockOperation:(UIButton *)sender {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"===%@", [NSThread currentThread]);
        }
    }];
    [op start];
}

// 3、如果一个 NSBlockOperation 对象封装了多个操作。NSBlockOperation 是否开启新线程，取决于操作的个数。如果添加的操作的个数多，就会自动开启新线程。当然开启的线程数是由系统来决定的。
- (IBAction)useAddExcuteoperation:(UIButton *)sender {
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

- (IBAction)useNSOperationSubClass:(UIButton *)sender {
    HGMOperation *op = [[HGMOperation alloc] init];
    [op start];
}


//----------------------------------------------队列---------------------------------------

// 5、创建操作，添加到创建的队列中执行
// 自定义的队列
- (IBAction)addOperationToQueue:(UIButton *)sender {
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
- (IBAction)useDepandency:(UIButton *)sender {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    
    // 添加依赖，op2执行完op1才执行
    [op1 addDependency:op2];
}

// 8、priority优先级

- (IBAction)usePriority:(UIButton *)sender {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"2---%@", [NSThread currentThread]);
        }
    }];
    
    HGMOperation *op3 = [[HGMOperation alloc] init];
    
    [op3 addDependency:op2];
    // op3依赖于op2，所以这里的Priority只对已经准备就绪状态的op1和op2有效
    // Priority不会影响op2与op3的执行x顺序
    op1.queuePriority = NSOperationQueuePriorityLow;
    op2.queuePriority = NSOperationQueuePriorityHigh;
    
    __weak typeof(op2) weakOp2 = op2;
    [op2 setCompletionBlock:^{
        // op2执行完毕之后的回调
        if (!weakOp2.isCancelled) {
            // 不是取消才是正常执行完毕(取消也会执行此回调)
            NSLog(@"op2 执行完毕后打印此信息");
        }
    }];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}

// 9、线程通讯

- (IBAction)threadCommunication:(UIButton *)sender {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"reflash UI");
            NSLog(@"2---%@", [NSThread currentThread]);
        }];
    }];
}

// 10、线程安全

- (IBAction)buyTicket:(UIButton *)sender {
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    queue1.maxConcurrentOperationCount = 1;
    
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    queue2.maxConcurrentOperationCount = 1;
    
    __weak typeof(self) weakSelf = self;
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf safeBuy];
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf safeBuy];
    }];
    
    [queue1 addOperation:op1];
    [queue2 addOperation:op2];
    
}

- (void)unsafeBuy {
    while (1) {
        if (self.tiketsCount > 0) {
            self.tiketsCount--;
            [NSThread sleepForTimeInterval:0.2];
            NSLog(@"tikets left %zd", self.tiketsCount);
        } else {
            break;
        }
    }
}

- (void)safeBuy {
    while (1) {
        
        [self.lock lock];
        
        if (self.tiketsCount > 0) {
            self.tiketsCount--;
            NSLog(@"tikets left %zd thread %@", self.tiketsCount, [NSThread currentThread]);
            [NSThread sleepForTimeInterval:0.2];
        }
        
        [self.lock unlock];
        
        if (self.tiketsCount == 0) {
            NSLog(@"sale out");
            break;
        }
    }
    self.lock = nil;
}

- (NSLock *)lock {
    if (!_lock) {
        _lock = [[NSLock alloc] init];
    }
    return _lock;
}

@end

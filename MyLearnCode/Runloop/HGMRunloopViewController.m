//
//  HGMRunloopViewController.m
//  11111
//
//  Created by Nick on 2018/7/26.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMRunloopViewController.h"

@interface HGMRunloopViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HGMRunloopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self performSelector:@selector(addTimer) withObject:nil afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
//    [self addTimer];
    [self addTableView];
    [self addTimerWithNewRunloop];
}

- (void)addTableView {
    UITableView *tbv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    tbv.dataSource = self;
    tbv.delegate = self;
    [self.view addSubview:tbv];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)addTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"printttttt");
    }];
    // NSDefaultRunLoopMode 在滑动列表时，停止timer
    // NSRunLoopCommonModes 在滑动列表时，timer继续工作
    // 方式一：把timer添加到NSDefaultRunLoopMode和UITrackingRunLoopMode两个mode当中
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    // 方式二：把timer添加到NSRunLoopCommonModes中，因为主线程的defaultmode和trackingmode已经标记为Common属性
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    // 方式三：把timer添加到RunLoop顶层的“Commonmodeitems”中
    [timer fire];
    self.timer = timer;
}

- (void)addTimerWithNewRunloop {
    
    NSThread *newThread = [[NSThread alloc] initWithTarget:self selector:@selector(testNewRunloop) object:nil];
    newThread.name = @"newThread";
    [newThread start];
}

- (void)testNewRunloop {
    NSThread *thread = [NSThread currentThread];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    NSRunLoop *mainrunloop = [NSRunLoop mainRunLoop];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"new");
    }];
    // 因为是另开的线程，所以主线程tableView的滑动，不会影响这里的timer
    [runloop addTimer:timer forMode:NSDefaultRunLoopMode];
    
    NSLog(@"\n thread%@, \n newrunloop%@, \n mainrunloop%@", thread, runloop, mainrunloop);
    
    [timer fire];
    
    // 5秒后停止runloop，结束线程，让timer失效
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CFRunLoopStop(CFRunLoopGetCurrent());
        [thread cancel];
        [timer invalidate];
    });
    [runloop run];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

@end

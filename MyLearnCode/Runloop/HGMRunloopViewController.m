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
    [self addTimer];
    [self addTableView];
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
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
    self.timer = timer;
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

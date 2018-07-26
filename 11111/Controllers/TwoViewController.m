//
//  TwoViewController.m
//  11111
//
//  Created by Nick on 2018/7/10.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "TwoViewController.h"
#import "ConstValueViewController.h"
#import <objc/runtime.h>
#import "HGMAutoDictionary.h"

typedef void(^block)(NSInteger inte);

static void *kAlertBlock = "kAlertBlock";

@interface TwoViewController () <UIAlertViewDelegate>

@property (nonatomic, copy) block myblock;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testConstValue) name:ConstValueViewControllerNotification object:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(100, 100, 30, 30);
    [btn addTarget:self action:@selector(aleartviewshow) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    HGMAutoDictionary *dict = [[HGMAutoDictionary alloc] init];
    dict.date = [NSDate dateWithTimeIntervalSince1970:0];
    dict.name = @"nick";
    NSLog(@"dict.date=%@,dict.name=%@", dict.date, dict.name);
}

- (void)aleartviewshow {
    UIAlertView *aleart = [[UIAlertView alloc] initWithTitle:@"question" message:@"make your choice" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"dosomething", nil];
    
    void (^alertBlock)(NSInteger) = ^(NSInteger index) {
        if (index == 0) {
            [self cancel];
        } else if (index == 1) {
            [self dosomething];
        }
    };
    // 运行时添加block属性，此处作用是让警告弹框的逻辑更紧密，不用再在相关代理方法里面查找这部分逻辑
    objc_setAssociatedObject(aleart, kAlertBlock, alertBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [aleart show];
}

- (void)cancel {
    NSLog(@"cancel");
}

- (void)dosomething {
    NSLog(@"dosomething");
}

#pragma alertview delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    void(^alertBlock)(NSInteger) = objc_getAssociatedObject(alertView, kAlertBlock);
    alertBlock(buttonIndex);
}

- (void)testConstValue {
    NSLog(@"recieve constValue notification");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ConstValueViewController *vc = [[ConstValueViewController alloc] init];
    vc.view.backgroundColor = [UIColor blueColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

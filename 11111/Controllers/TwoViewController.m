//
//  TwoViewController.m
//  11111
//
//  Created by Nick on 2018/7/10.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "TwoViewController.h"
#import "ConstValueViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testConstValue) name:ConstValueViewControllerNotification object:nil];
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

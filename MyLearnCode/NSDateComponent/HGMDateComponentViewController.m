//
//  HGMDateComponentViewController.m
//  MyLearnCode
//
//  Created by Nick on 2018/9/20.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMDateComponentViewController.h"

@interface HGMDateComponentViewController ()

@end

@implementation HGMDateComponentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test1];
    [self test2];
    [self test3];
}

- (void)test1 {
    // 自定义NSDate对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:1987];
    [components setMonth:3];
    [components setDay:17];
    [components setHour:14];
    [components setMinute:20];
    [components setSecond:0];
    
    NSLog(@"Awesome time: %@", [calendar dateFromComponents:components]);
}

- (void)test2 {
    // 创建距某个时间点前后的时间
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfMonth:1];
    [components setHour:12];
    
    NSLog(@"1 week and twelve hours from now: %@", [calendar dateByAddingComponents:components toDate:date options:0]);
}

- (void)test3 {
    // 按需创建日期：如年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    NSDateComponents *component = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitHour) fromDate:date];
    NSLog(@"component%@", component);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  HGMRACView.m
//  MyLearnCode
//
//  Created by Nick on 2018/8/30.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMRACView.h"

@implementation HGMRACView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button addTarget:self action:@selector(racBtnClick) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(100, 0, 100, 40);
    [self addSubview:button];
}

- (void)racBtnClick {
    NSLog(@"racBtnClick");
}



@end

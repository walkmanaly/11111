//
//  HGMOperation.m
//  MyLearnCode
//
//  Created by Nick on 2018/9/25.
//  Copyright © 2018 nick. All rights reserved.
//

#import "HGMOperation.h"

@implementation HGMOperation

- (void)main {
    if (!self.isCancelled) {
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"---%@", [NSThread currentThread]);
        }
    }
}

@end

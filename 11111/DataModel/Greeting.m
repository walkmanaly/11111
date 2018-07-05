//
//  Greeting.m
//  11111
//
//  Created by Nick on 2018/7/5.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "Greeting.h"

@implementation Greeting

+ (instancetype)greetingWithId:(NSString *)id content:(NSString *)content {
    Greeting *gre = [[Greeting alloc] init];
    gre.id = id;
    gre.content = content;
    return gre;
}

@end

//
//  HGMValue.m
//  11111
//
//  Created by Nick on 2018/8/2.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMValue.h"

typedef struct example {
    id   anObject;
    char *aString;
    int  anInt;
} Example;

@implementation HGMValue

- (instancetype)init {
    if (self = [super init]) {
        
        
        
        return self;
    }
    return nil;
}

- (void)testNSValue {
    void *aa = "hello";
    NSValue *value = [NSValue valueWithBytes:aa objCType:@encode(NSNumber)];
    NSLog(@"%@", value);
}

@end

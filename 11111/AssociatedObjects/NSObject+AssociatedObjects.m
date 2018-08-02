//
//  NSObject+AssociatedObjects.m
//  11111
//
//  Created by Nick on 2018/7/24.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "NSObject+AssociatedObjects.h"
#import <objc/runtime.h>

static const void *kAssociatedObject;
static const void *kAssociatedDelegate;

@implementation NSObject (AssociatedObjects)

- (void)setAssociatedObject:(NSString *)associatedObject {
    objc_setAssociatedObject(self, kAssociatedObject, associatedObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)associatedObject {
    return objc_getAssociatedObject(self, kAssociatedObject);
}

- (void)setDelegate:(id<AssociatedObjectsProtocol>)delegate {
    objc_setAssociatedObject(self, kAssociatedDelegate, delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<AssociatedObjectsProtocol>)delegate {
    return objc_getAssociatedObject(self, kAssociatedDelegate);
}

- (void)associatiedMethod {
//    NSLog(@"associatiedMethod");
//    if ([self.delegate respondsToSelector:@selector(associatedObjectsProtocolMethod)]) {
        [self.delegate associatedObjectsProtocolMethod];
//    }
}

@end

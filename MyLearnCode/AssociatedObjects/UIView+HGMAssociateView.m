//
//  UIView+HGMAssociateView.m
//  MyLearnCode
//
//  Created by Nick on 2018/9/21.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "UIView+HGMAssociateView.h"
#import <objc/runtime.h>

static const void *kViewAssosiateObj;
static const void *kViewAssosiateDelegate;

@implementation UIView (HGMAssociateView)



- (void)setDesc:(NSString *)desc {
    objc_setAssociatedObject(self, kViewAssosiateObj, desc, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)desc {
    return objc_getAssociatedObject(self, kViewAssosiateObj);
}

- (void)setDelegate:(id<AssociateViewProtocol>)delegate {
    objc_setAssociatedObject(self, kViewAssosiateDelegate, delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<AssociateViewProtocol>)delegate {
    return objc_getAssociatedObject(self, kViewAssosiateDelegate);
}

- (void)removeFromSuperview {
    if ([self.delegate respondsToSelector:@selector(test)]) {
        [self.delegate test];
    }
}

@end

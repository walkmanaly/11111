//
//  UIView+HGMAssociateView.h
//  MyLearnCode
//
//  Created by Nick on 2018/9/21.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AssociateViewProtocol <NSObject>

@optional
- (void)test;

@end

@interface UIView (HGMAssociateView)

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, weak) id <AssociateViewProtocol> delegate;

@end

//
//  NSObject+AssociatedObjects.h
//  11111
//
//  Created by Nick on 2018/7/24.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AssociatedObjectsProtocol

- (void)associatedObjectsProtocolMethod;

@end

@interface NSObject (AssociatedObjects)

@property (nonatomic, strong) NSString *associatedObject;
@property (nonatomic, weak) id<AssociatedObjectsProtocol> delegate;

- (void)associatiedMethod;

@end

NS_ASSUME_NONNULL_END

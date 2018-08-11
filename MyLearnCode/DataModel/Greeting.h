//
//  Greeting.h
//  11111
//
//  Created by Nick on 2018/7/5.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Greeting : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *content;

+ (instancetype)greetingWithId:(NSString *)id content:(NSString *)content;

@end

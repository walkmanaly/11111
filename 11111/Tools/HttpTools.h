//
//  HttpTools.h
//  11111
//
//  Created by Nick on 2018/7/5.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completetionBlock)(NSString *responseObject);
typedef void(^successedBlock)(NSDictionary *successed);
typedef void(^failuredBlock)(NSString *failured);
typedef void(^NetworkCompletionhandler)(NSDictionary *data, NSError *error);

@interface HttpTools : NSObject

+ (void)getWithParams:(NSString *)params successed:(successedBlock)successed failured:(failuredBlock)failured;
+ (void)getRequestWithSuccess:(successedBlock)successed failured:(failuredBlock)failured;
+ (void)getWithParams:(NSString *)params completionhandler:(NetworkCompletionhandler)handler;

@end

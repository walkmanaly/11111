//
//  HttpTools.m
//  11111
//
//  Created by Nick on 2018/7/5.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HttpTools.h"
#import <AFNetworking.h>

#define baseurl @"http://localhost:8080"

@interface HttpTools ()

@end

@implementation HttpTools

+ (void)getWithParams:(NSString *)params successed:(successedBlock)successed failured:(failuredBlock)failured {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseurl]];
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];

    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:@"/greeting?name=Nick" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        successed(response);
        NSDictionary *serializationDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"%@", serializationDict);
        successed(serializationDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorStr = NSStringFromClass([NSError class]);
        failured(errorStr);
    }];
}

+ (void)getRequestWithSuccess:(successedBlock)successed failured:(failuredBlock)failured {
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/greeting" ,baseurl]] cachePolicy:1 timeoutInterval:20];
    NSURLSessionDataTask *session = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", response);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
        
                NSLog(@"%@", dict);
        successed(dict);
        
    }];
    
    [session resume];
    
}

@end

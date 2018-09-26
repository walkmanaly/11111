//
//  main.m
//  11111
//
//  Created by Nick on 2018/6/28.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <objc/runtime.h>
#import "AppDelegate.h"
//#import "HGMClass.h"

//void PrintClassInfo(id obj) {
//    Class cls = object_getClass(obj);
//    Class superCls = class_getSuperclass(cls);
//    NSLog(@"---%s : %s---", class_getName(cls), class_getName(superCls));
//}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
//        HGMClass *obj = [[HGMClass alloc] init];
//        NSLog(@"before");
//        PrintClassInfo(obj);
//        [obj release];
//        NSLog(@"after");
//        PrintClassInfo(obj);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}












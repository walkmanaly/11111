//
//  HGMNSEnume.m
//  11111
//
//  Created by Nick on 2018/8/8.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMNSEnume.h"

@implementation HGMNSEnume

- (void)testEnume {
    NSLog(@"%zd-%zd-%zd-%zd", HGMDerectionEast, HGMDerectionWest, HGMDerectionSouth, HGMDerectionNorth);
    if (HGMDerectionNorth | HGMDerectionWest | HGMDerectionSouth | HGMDerectionEast) {
        NSLog(@"all derection");
    }
    
    switch (_derection) {
        case HGMDerectionNorth:
            NSLog(@"north");
            break;
            
        case HGMDerectionSouth:
            NSLog(@"south");
            break;
            
        case HGMDerectionWest:
            NSLog(@"west");
            break;
            
//        case HGMDerectionEast:
//            NSLog(@"east");
//            break;
            // 最好不要用default分支，在新增枚举类型的时候，编译器会有警告信息，而不会直接走default分支
            // Enumeration value 'HGMDerectionEast' not handled in switch 少写了一种状态警告提示~
//        default:
//            break;
    }
}

@end

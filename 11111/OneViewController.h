//
//  OneViewController.h
//  11111
//
//  Created by Nick on 2018/7/10.
//  Copyright © 2018年 nick. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SendTextBlock)(NSString *str);

@interface OneViewController : UIViewController

@property (nonatomic, copy) SendTextBlock sendTextBlock;

@end

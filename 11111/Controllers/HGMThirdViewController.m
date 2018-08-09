//
//  HGMThirdViewController.m
//  11111
//
//  Created by Nick on 2018/8/9.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMThirdViewController.h"
#import <objc/runtime.h>

@interface HGMThirdViewController ()

@end

@implementation HGMThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testPrivateMethod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testPrivateMethod {
    // _resetViewController 是UIviewcontroller的私有方法，不对外公开接口，实际上内部实现了此方法。
    // 我们在定义私有方法时，避免使用_开头(苹果私有方法默认以_开头)，防止覆写了父类的私有方法，导致该调的父类方法没有执行，产生错误
    BOOL isResponds = [self respondsToSelector:@selector(_resetViewController)];
    NSLog(@"isResponds---%d", isResponds);
    
    Class clz = [self class];
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(clz, &methodCount);
    printf("Found %d methods on '%s'\n", methodCount, class_getName(clz));
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methods[i];
        printf("\t'%s' has method named '%s' of encoding '%s'\n",
               class_getName(clz),
               sel_getName(method_getName(method)),
               method_getTypeEncoding(method));
        /**
         *  Or do whatever you need here...
         */
    }
    free(methods);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

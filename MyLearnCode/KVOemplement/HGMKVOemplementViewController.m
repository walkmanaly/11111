//
//  HGMKVOemplementViewController.m
//  11111
//
//  Created by Nick on 2018/8/2.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMKVOemplementViewController.h"
#import "HGMKVOObject.h"
#import <objc/runtime.h>

@interface HGMKVOemplementViewController ()

@end

/*
 总结：
 1、addObserver之后，被观察者动态创建NSKVONotifying_HGMKVOObject子类
 2、属性值改变时：先调用willChangeValueForKey方法
               再调用该属性的setter方法
               然后调用didChangeValueForKey-begin触发代理回调方法didChangeValueForKey-end
 */

@implementation HGMKVOemplementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    HGMKVOObject *obj1 = [[HGMKVOObject alloc] init];
    HGMKVOObject *obj2 = [[HGMKVOObject alloc] init];
    
    obj1.age = 10;
    obj1.name = @"rose";
    obj2.age = 20;
    
    // 通过methodForSelector找到方法实现的地址
    NSLog(@"添加KVO监听之前 - obj1 = %p, obj2 = %p", [obj1 methodForSelector: @selector(setAge:)],[obj2 methodForSelector: @selector(setAge:)]);
    
    NSLog(@"添加KVO监听之前 - obj1 = %p, obj2 = %p", [obj1 methodForSelector: @selector(setName:)],[obj2 methodForSelector: @selector(setName:)]);
    
    [obj1 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [obj1 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    /*
     1---runtime动态创建子类
     添加观察者之后调试：
     po obj1->isa
     输出：NSKVONotifying_HGMKVOObject
     */
    
    // age值改变后触发回调方法
    obj1.age = 50;
    obj1.name = @"nick";
    
//    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
//    [obj2 addObserver:self forKeyPath:@"age" options:options context:nil];
    
    /*
     2---子类实现监听
     添加KVO监听之前 - obj1 = 0x10fcc5130, obj2 = 0x10fcc5130
     添加KVO监听之后 - obj1 = 0x1109789b4, obj2 = 0x10fcc5130
     方法实现的地址发生了变化：
     p (IMP)0x10fcc5130
     (IMP) $0 = 0x000000010fcc5130 (11111`-[HGMKVOObject setAge:] at HGMKVOObject.h:15)
     p (IMP)0x1109789b4
     转换为了C语言的Foundation框架的_NSsetLongLongValueAndNotify函数：
     (IMP) $1 = 0x00000001109789b4 (Foundation`_NSSetLongLongValueAndNotify)---NSInteger
     
     如果属性是double，则转换为(Foundation`_NSSetDoubleValueAndNotify)--double
     如果属性是对象，则转换为(Foundation`_NSSetObjectValueAndNotify)--NSString
     */
    
    NSLog(@"添加KVO监听之后 - obj1 = %p, obj2 = %p", [obj1 methodForSelector: @selector(setAge:)],[obj2 methodForSelector: @selector(setAge:)]);

    NSLog(@"添加KVO监听之后 - obj1 = %p, obj2 = %p", [obj1 methodForSelector: @selector(setName:)],[obj2 methodForSelector: @selector(setName:)]);
    /*
     3---NSKVONotifying_HGMKVOObject内部结构
     HGMKVOObject - setAge: age
     NSKVONotifying_HGMKVOObject - setAge: class dealloc _isKVOA
     重写了class方法返回HGMKVOObject隐藏了创建的NSKVONotifying_HGMKVOObject
     */
    
    [self printMethods: object_getClass(obj2)];
    [self printMethods: object_getClass(obj1)];
    
    [obj1 removeObserver:self forKeyPath:@"age"];
    [obj1 removeObserver:self forKeyPath:@"name"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    if ([keyPath isEqualToString:@"age"]) {
//        id newKey = [change objectForKey:NSKeyValueChangeNewKey];
//        id oldKey = [change objectForKey:NSKeyValueChangeOldKey];
//        NSLog(@"age change newValue:%@-oldValue:%@", newKey, oldKey);
//    }
    NSLog(@"\n监听到keypath%@\n对象%@\n新旧值%@", keyPath, object, change);
}

- (void)printMethods:(Class)cls
{
    unsigned int count ;
    Method *methods = class_copyMethodList(cls, &count);
    NSMutableString *methodNames = [NSMutableString string];
    [methodNames appendFormat:@"%@ - ", cls];
    
    for (int i = 0 ; i < count; i++) {
        Method method = methods[i];
        NSString *methodName  = NSStringFromSelector(method_getName(method));
        
        [methodNames appendString: methodName];
        [methodNames appendString:@" "];
        
    }
    
    NSLog(@"%@",methodNames);
    free(methods);
}


@end

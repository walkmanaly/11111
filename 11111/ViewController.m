//
//  ViewController.m
//  11111
//
//  Created by Nick on 2018/6/28.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "ViewController.h"
#import "HttpTools.h"
#import "Greeting.h"
#import "Product.h"
#import "OneViewController.h"
#import <objc/runtime.h>
#import "Book.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, strong) NSMutableArray *iMacs;

@end

@implementation ViewController

- (NSMutableArray *)iMacs {
    if (!_iMacs) {
        _iMacs = [NSMutableArray array];
        Product *p1 = [Product prductWithName:@"iMac" price:2000 date:[NSDate dateWithTimeIntervalSinceNow:0]];
        Product *p2 = [Product prductWithName:@"iMac" price:3000 date:[NSDate dateWithTimeIntervalSinceNow:20]];
        Product *p3 = [Product prductWithName:@"iMac" price:4000 date:[NSDate dateWithTimeIntervalSinceNow:30]];
        [_iMacs addObject:p1];
        [_iMacs addObject:p2];
        [_iMacs addObject:p3];
    }
    return _iMacs;
}

- (NSMutableArray *)products {
    if (!_products) {
        _products = [NSMutableArray array];
        Product *p1 = [Product prductWithName:@"iphone5" price:2000 date:[NSDate dateWithTimeIntervalSinceNow:0]];
        Product *p2 = [Product prductWithName:@"iphone5" price:3000 date:[NSDate dateWithTimeIntervalSinceNow:20]];
        Product *p3 = [Product prductWithName:@"iphone6" price:4000 date:[NSDate dateWithTimeIntervalSinceNow:30]];
        Product *p4 = [Product prductWithName:@"iphone7" price:5000 date:[NSDate dateWithTimeIntervalSinceNow:40]];
        [_products addObject:p1];
        [_products addObject:p2];
        [_products addObject:p3];
        [_products addObject:p4];
    }
    return _products;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"hello world");

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

//    [self demoKVC];
//    [self demoDecode];
//    [self testRunLoop];
    [self demoRequest];
}

- (void)testRunLoop {
    
    NSRunLoop *maimLoop = [NSRunLoop mainRunLoop];
    dispatch_queue_t queue = dispatch_queue_create("Nick", NULL);
    dispatch_async(queue, ^{
        NSRunLoop *currruntloop = [NSRunLoop currentRunLoop];
        NSLog(@"currruntloop:%@", currruntloop);
    });
    NSLog(@"maimLoop:%@", maimLoop);
    
}

- (void)demoTestPush {
    
    OneViewController *vc = [[OneViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)methodNameListOfArray {
    
    unsigned int methodCount = 0;
    Method * methods = class_copyMethodList([NSArray class], &methodCount);
    for (int i = 0; i < methodCount; ++i) {
        Method m = methods[i];
        NSLog(@"%@", NSStringFromSelector(method_getName(m)));
    }
    free(methods);
}

- (void)demoRequest {
    [HttpTools getWithParams:@"?name=Nick" successed:^(NSDictionary *successed) {
        NSLog(@"successed%@", successed);
        Greeting *greet = [Greeting greetingWithId:successed[@"id"] content:successed[@"content"]];
        NSLog(@"greet.id=%@, greet.content=%@", greet.id, greet.content);
    } failured:^(NSString *failured) {
        NSLog(@"failured%@", failured);
    }];
    
//    [HttpTools getRequestWithSuccess:^(NSDictionary *successed) {
//
//    } failured:^(NSString *failured) {
//
//    }];
}

- (void)demoNsoperation {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op");
    }];
    
    //    [op start];
    
    [queue addOperation:op];
    
    NSBlockOperation *clockOp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"clockOp");
    }];
    [queue addOperation:clockOp];
    
    [clockOp addDependency:op];
    
}

- (void)demoKVC {
    
    //    id result = [self.products valueForKeyPath:@"@max.date"];
    Product *p4 = self.products[3];
    [p4 setValue:@"iphone8" forKeyPath:@"name"];
    // 简单的集合运算符
    id names = [self.products valueForKeyPath:@"@max.name"];
    NSLog(@"%@", names);
    
    id valuesKeys = [self.products dictionaryWithValuesForKeys:@[@"name", @"date", @"price"]];
    NSLog(@"%@", valuesKeys);
    
    // 对象运算符
    
    //    NSArray *types = @[@"iphnoe", @"ipad", @"ipad", @"macbook", @"macbook", @"macbook"];
    
    id unionObj = [self.products valueForKeyPath:@"@unionOfObjects.name"];
    // distinct去重
    id distinObj = [self.products valueForKeyPath:@"@distinctUnionOfObjects.name"];
    NSLog(@"%@- %@", unionObj, distinObj);
    
    // 数组和集合操作符
    id unionArr = [@[self.products, self.iMacs] valueForKeyPath:@"@unionOfArrays.name"];
    id distinctUnionArr = [@[self.products, self.iMacs] valueForKeyPath:@"@distinctUnionOfArrays.name"];
    NSLog(@"%@- %@", unionArr, distinctUnionArr);
    
}

- (void)demoDecode {
    Book *book = [[Book alloc] init];
    book.title = @"code complete";
    book.desc = @"代码大全";
    book.pages = 625.0;
    book.avilible = YES;
    
    NSString *Deocument = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [NSString stringWithFormat:@"%@/file", Deocument];
    
    
    BOOL isSuccessed = [NSKeyedArchiver archiveRootObject:book toFile:path];
    
    Book *unarch = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"%@", unarch);
}

@end

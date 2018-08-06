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
#import "AssociatedObjectViewController.h"
#import "HGMRunloopViewController.h"
#import "NSString+HGMMethodSwizzling.h"
#import "HGMPartimeViewController.h"
#import "HGMKVOemplementViewController.h"
#import "HGMRetangle.h"
#import "HGMSquier.h"
#import "HGMDeallocBlockViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, strong) NSMutableArray *iMacs;
@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) Greeting *myGreeting;
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

//    [self testRuntime1];
//    [self demoRequest];
//    [self pushToHGMRunloopViewController];
//    [self testMethodSwizzling];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self demoTestPush];
//    [self pushAssociatedObjectViewController];
//    [self demoKVC];
//    [self demoDecode];
//    [self testRunLoop];
//    [self demoRequest];
//    [self testRuntime];
//    [self testCPointer];
    
//    int num = 5;
//    // 同c语言，调用函数是值传递，传的是值拷贝
//    [self testValueType:num];
//    NSLog(@"%d", num);
    
//    [self testNSOperationObject];
//    [self testProtocol];
//    [self testKVOemplementation];
//    [self testDesignatedInitializer];
//    [self testDeallocBlock];
    [self testPrivateMethod];
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

- (void)testDeallocBlock {
    HGMDeallocBlockViewController *vc = [[HGMDeallocBlockViewController alloc] init];
    vc.view.backgroundColor = [UIColor lightTextColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)testDesignatedInitializer {
//    HGMRetangle *rect = [[HGMRetangle alloc] init];
//    NSLog(@"\n%f-%f", rect.width, rect.height);
//
//    HGMSquier *qure = [[HGMSquier alloc] init];
//    NSLog(@"\n%f--%f", qure.width, qure.height);
    
    HGMSquier  *squre = [[HGMSquier alloc] init];
    squre.name = @"Nick";
    
    NSString *domain = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [NSString stringWithFormat:@"%@%@", domain, @"/file"];
//    NSURL *pathUrl = [NSURL URLWithString:path];
    [NSKeyedArchiver archiveRootObject:squre toFile:path];
    
    id result = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"%@", result);
}

- (void)testKVOemplementation {
    HGMKVOemplementViewController *vc = [[HGMKVOemplementViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)testProtocol {
    HGMPartimeViewController *vc = [[HGMPartimeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)testNSOperationObject {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.name = @"com.cn.nick.operationQueue";
    
    NSBlockOperation *op1 = [[NSBlockOperation alloc] init];
    __weak typeof(op1) weakOp1 = op1;
    [op1 addExecutionBlock:^{
        for (int i = 0 ; i < 10; i++) {
            NSLog(@"%d", i);
            if (i == 5) {
//                [queue cancelAllOperations];
                [weakOp1 cancel];
                NSLog(@"%@", queue.name);
                break;
            }
        }
    }];
    
//    op1.isCancelled
    [queue addOperation:op1];
    
    [op1 addObserver:self forKeyPath:@"isExecuting" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    [op1 addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    [op1 addObserver:self forKeyPath:@"isCancelled" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"11");
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"22");
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"33");
    });
    dispatch_group_enter(group);
    dispatch_group_leave(group);
    
    // 会阻塞线程，等组里所有任务执行完再往下走
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    // 阻力所有任务都执行完后收到通知,一般回到主线程执行block里e的任务
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"group task all done");
    });
    
    // 反复执行block里面的代码，根据传入的次数，此处：5
    dispatch_apply(5, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t i) {
        NSLog(@"iii%zu", i);
    });
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isExecuting"]) {
        NSLog(@"isExecuting...");
    }
    if ([keyPath isEqualToString:@"isFinished"]) {
        NSLog(@"isFinished");
    }
    if ([keyPath isEqualToString:@"isCancelled"]) {
        NSLog(@"isCancelled");
    }
}

- (void)testMethodSwizzling {
//    NSString *myStr = [[NSString stringWithFormat:@"hello"] uppercaseString];
//    NSLog(@"%@", myStr);
//    myStr = [myStr uppercaseString];
//    NSLog(@"");
}

- (void)pushToHGMRunloopViewController {
    HGMRunloopViewController *vc = [[HGMRunloopViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushAssociatedObjectViewController {
    AssociatedObjectViewController *vc = [[AssociatedObjectViewController alloc] init];
    vc.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)testValueType:(int)num {
    num += 10;
}

- (void)testCPointer {
    int x = 1, y = 2, z[20];
    int *ip;                    //
    ip = &x;
    y = *ip;                    // 此处*ip == 1
    *ip = 0;                    // 此处间接访问变量x，并把0赋值给x，x = 0
    ip = &z[0];
    NSLog(@"\n&x=%p-------y=%d------x=%d-------&z=%p", ip, y, x, ip);
    
}



- (void)testRuntimeCreateNewClass {
    
}

- (void)testRuntime1 {
    const char *clsName = class_getName([NSObject class]);
    Class supClass = class_getSuperclass([NSObject class]);
    BOOL isMeta = class_isMetaClass([NSObject class]);
    NSLog(@"\nclsName=%s\n supClass=%@\n isMeta=%d", clsName, supClass, isMeta);
    id strCls = class_createInstance(Greeting.class, sizeof(unsigned));
    id obj = [strCls init];
    NSLog(@"%@", obj);
}

- (void)testRuntime {
    const char *name = class_getName([self class]);
    Class cls = class_getSuperclass([self class]);
    BOOL meta = class_isMetaClass([self class]);
    size_t size = class_getInstanceSize([self class]);
    
//    const char *view = "view";
//    Ivar ii = class_getInstanceVariable([self class], view);
    unsigned int count = 0;
    Ivar *ivas = class_copyIvarList([self class], &count);
    for (int i =0; i < count; i++) {
        Ivar ivar = ivas[i];
        NSLog(@"ivar=%s", ivar_getName(ivar));
    }
    NSLog(@"%s-%@-%d-%zu", name, cls, meta, size);
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
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    [self.view addSubview:self.textLabel];
    
    OneViewController *vc = [[OneViewController alloc] init];
    vc.sendTextBlock = ^(NSString *str) {
        self.textLabel.text = str;
    };
    
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
        self.myGreeting = [Greeting greetingWithId:successed[@"id"] content:successed[@"content"]];
        NSLog(@"----greet.id=%@, greet.content=%@", self.myGreeting.id, self.myGreeting.content);
    } failured:^(NSString *failured) {
        NSLog(@"failured%@", failured);
    }];
    
//    [HttpTools getRequestWithSuccess:^(NSDictionary *successed) {
//
//    } failured:^(NSString *failured) {
//
//    }];
}

- (void)demoHandlerRequest {
    [HttpTools getWithParams:@"?name=Nick" completionhandler:^(NSDictionary *data, NSError *error) {
        // 出错处理
        if (error) {
            NSLog(@"error occur");
            return ;
        }
        
        // 解析数据
        self.myGreeting = [Greeting greetingWithId:data[@"id"] content:data[@"content"]];
        NSLog(@"----greet.id=%@, greet.content=%@", self.myGreeting.id, self.myGreeting.content);
        
    }];
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
    
//    CFRunLoopRef runloop = CFRunLoopGetCurrent();
//    NSArray *allModels = CFBridgingRelease(CFRunLoopCopyAllModes(runloop));
//    while (1) {
//        for (NSString *mode in allModels) {
//            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
//        }
//    }
    
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

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"isExecuting"];
    [self removeObserver:self forKeyPath:@"isFinished"];
    [self removeObserver:self forKeyPath:@"isCancelled"];
}

@end

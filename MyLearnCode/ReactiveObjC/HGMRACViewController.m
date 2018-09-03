//
//  HGMRACViewController.m
//  MyLearnCode
//
//  Created by Nick on 2018/8/30.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMRACViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "LoginManager.h"
#import "HGMRACView.h"

static const NSString *UserDidLogOutNotification = @"UserDidLogOutNotification";

@interface HGMRACViewController ()

@property (nonatomic, strong) UIButton *logInButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) HGMRACView *racView;

@property (nonatomic, assign) BOOL loggedIn;
@property (nonatomic, assign) BOOL loggingIn;

@property (nonatomic, copy) NSString *stringKey;
@property (nonatomic, strong) RACDisposable *disposable;

@end

@implementation HGMRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 20)];
    _usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_usernameTextField];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 120, 200, 20)];
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_passwordTextField];
    
    _logInButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 230, 200, 40)];
    [_logInButton setTitle:@"login" forState:UIControlStateNormal];
    [_logInButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [_logInButton setBackgroundImage:[UIImage imageNamed:@"GodfreyKneller-IsaacNewton-1689.jpg"] forState:UIControlStateNormal];
    [_logInButton setBackgroundImage:[UIImage imageNamed:@"timg.jpeg"] forState:UIControlStateDisabled];
    [self.view addSubview:_logInButton];
    
    _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 280, 200, 40)];
    [_registerButton setTitle:@"register" forState:UIControlStateNormal];
    [_registerButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.view addSubview:_registerButton];
    
    _racView = [[HGMRACView alloc] initWithFrame:CGRectMake(0, 400, 300, 100)];
    _racView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_racView];
    
    [self demo4];
    [self demo5];
    [self demo6];
    [self demo7];
    [self demo8];
    [self demo9];
    [self demo10];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self demo2];
    //    [self demo3];
    self.stringKey = @"rose";
    // 与kvo一致，调用setter方法才会触发
//    _stringKey = @"nick";
}

- (void)demo1 {
    // 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送信号
        [subscriber sendNext:@"send"];
        return nil;
    }];
    // 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

// RACsubject------------------测试时，并没有订阅到信号？
- (void)demo2 {
    // 创建信号
    RACSubject *subject = [RACSubject subject];
    // 发送信号
    [subject sendNext:@"send subject"];
    // 订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

// 遍历数组
- (void)demo3 {
    NSArray *array = @[@"2",@"4",@"5",@"8",@"1"];
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"遍历数组%@", x);
    }];
}

// 监听输入框
- (void)demo4 {
    // 输入框内容改变就会调用
    [[_usernameTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [[[_usernameTextField rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
        BOOL flag = value.length > 6 ? YES : NO;
        return flag;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"value.length > 6,接收到%@", x);
    }];
}

// 监听按钮点击
- (void)demo5 {
    [[_logInButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        // 按钮点击就会触发,把button传进来(x就是_logInButton)
        NSLog(@"%@", x);
    }];
}

// 登录按钮状态改变，判断输入框是否填写
- (void)demo6 {
    RAC(_logInButton, enabled) = [RACSignal combineLatest:@[_usernameTextField.rac_textSignal, _passwordTextField.rac_textSignal] reduce:^id _Nonnull{
        return @(self->_usernameTextField.text.length>0 && self->_passwordTextField.text.length>0);
    }];
}

// RAC通知,省去在dealloc中移除观察者
- (void)demo7 {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextFieldTextDidChangeNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        // 当输入框值改变时接收到通知,x时通知对象，此处为输入框
        NSLog(@"UITextFieldTextDidChangeNotification=%@", x);
    }];
}

// RAC代理       racView中的racBtnClick方法被执行时，此处收到信号，处理信号
- (void)demo8 {
    [[_racView rac_signalForSelector:@selector(racBtnClick)] subscribeNext:^(RACTuple * _Nullable x) {
        // 当racView调用racViewBtnClickr时，获得订阅
        NSLog(@"Delegate%@", x);
    }];
}

// RAC实现kvo
- (void)demo9 {
    [[self rac_valuesForKeyPath:@"stringKey" observer:self] subscribeNext:^(id  _Nullable x) {
        // 属性调用setter方法触发
        NSLog(@"stringKey--%@", x);
    }];
}

// RAC定时器
- (void)demo10 {
    self.disposable = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"disposable--%@", x);
        [self->_disposable dispose];
    }];
}

- (void)officalExsample {
    //    @weakify(self);
    //
    //    RAC(self.logInButton, enabled) = [RACSignal
    //                                      combineLatest:@[
    //                                                      self.usernameTextField.rac_textSignal,
    //                                                      self.passwordTextField.rac_textSignal,
    //                                                      RACObserve(LoginManager.sharedManager, loggingIn),
    //                                                      RACObserve(self, loggedIn)
    //                                                      ] reduce:^(NSString *username, NSString *password, NSNumber *loggingIn, NSNumber *loggedIn) {
    //                                                          return @(username.length > 0 && password.length > 0 && !loggingIn.boolValue && !loggedIn.boolValue);
    //                                                      }];
    //
    //    [[self.logInButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
    //        @strongify(self);
    //
    //        RACSignal *loginSignal = [LoginManager.sharedManager
    //                                  logInWithUsername:self.usernameTextField.text
    //                                  password:self.passwordTextField.text];
    //
    //        [loginSignal subscribeError:^(NSError *error) {
    //            @strongify(self);
    //            [self presentError:error];
    //        } completed:^{
    //            @strongify(self);
    //            self.loggedIn = YES;
    //        }];
    //    }];
    //
    //    RAC(self, loggedIn) = [[NSNotificationCenter.defaultCenter
    //                            rac_addObserverForName:UserDidLogOutNotification object:nil]
    //                           mapReplace:@NO];
    //
}
//- (void)presentError:(NSError *)error {
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

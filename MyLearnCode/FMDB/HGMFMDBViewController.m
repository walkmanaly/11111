//
//  HGMFMDBViewController.m
//  MyLearnCode
//
//  Created by Nick on 2018/8/13.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMFMDBViewController.h"
#import "FMDB.h"

@interface HGMFMDBViewController ()

@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

@end

@implementation HGMFMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *homeDir = NSHomeDirectory();
    NSLog(@"homeDir-%@", homeDir);
    
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"document-%@", document);
    
    NSString *library = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"libraly-%@", library);
    
    // 此方法获取路径是沙盒/Library/PreferencePanes，但并不存在这样的路径，想要访问Preferences文件夹，需要拼接路径。
    NSString *preferance = [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"preferance-%@", preferance);
    
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"cache-%@", cache);
    
    NSString *temp = NSTemporaryDirectory();
    NSLog(@"temp-%@", temp);
    
    // 保存到Library的Preferences中
    [[NSUserDefaults standardUserDefaults] setObject:@"hello" forKey:@"hello"];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"/myDatabase"];
    NSLog(@"%@", path);
    self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            NSLog(@"打开数据库成功");
            NSString *sql =  @"CREATE TABLE IF NOT EXISTS t_student (idstr INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL, score REAL DEFAULT 60.0);";
            if ([db executeUpdate:sql]) {
                NSLog(@"创建表成功");
            } else {
                NSLog(@"创建失败");
            }
        }
    }];
    
}
- (IBAction)insertDataAction:(UIButton *)sender {
    //4.添加数据指定行显示内容
    //1.增加  100条数据  (name,score)  jack-0-100
    
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        
        for (int i = 0; i <100;i++) {
            NSString *name = [NSString stringWithFormat:@"jack-%d",i];
            CGFloat score = arc4random_uniform(600)/10.0 + 40;
            
            NSString *sqlstr = [NSString stringWithFormat:@"INSERT INTO t_student (name,score) VALUES ('%@',%.2f);",name,score];
            
            BOOL success =  [db executeUpdate:sqlstr];
            if (success) {
                NSLog(@"添加成功!");
            }else{
                NSLog(@"添加失败!");
            }
        }
        
    }];
}
- (IBAction)selectDataAction:(UIButton *)sender {
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        
        //4.查询  > 90
        NSString *sqlstr = @"SELECT name,score FROM t_student WHERE score > 90.0;";
        
        FMResultSet *set = [db executeQuery:sqlstr];
        
        while ([set next]) {
            NSString *name = [set stringForColumn:@"name"];
            CGFloat score = [set doubleForColumn:@"score"];
            NSLog(@"name = %@ , score = %.2f",name,score);
        }
        
    }];
}

@end

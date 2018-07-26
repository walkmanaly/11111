//
//  HGMAutoDictionary.m
//  11111
//
//  Created by Nick on 2018/7/26.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "HGMAutoDictionary.h"
#import <objc/runtime.h>

@interface HGMAutoDictionary ()

@property (nonatomic, strong) NSMutableDictionary *mutDict;

@end

@implementation HGMAutoDictionary

@dynamic name, date;

- (instancetype)init {
    if (self = [super init]) {
        _mutDict = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selectorString = NSStringFromSelector(sel);
    if ([selectorString hasPrefix:@"set"]) {
        class_addMethod(self, sel, (IMP)autoDictionarySetter, "v@:@");
    } else {
        class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
    }
    return YES;
}

void autoDictionarySetter(id self, SEL _cmd, id value) {
    HGMAutoDictionary *selfType = (HGMAutoDictionary *)self;
    NSMutableDictionary *mutDict = selfType.mutDict;
    
    NSString *valueKey = NSStringFromSelector(_cmd);
    
    NSMutableString *key = [valueKey mutableCopy];
    // 删掉setter方法后面的 “:”
    [key deleteCharactersInRange:NSMakeRange(key.length - 1, 1)];
    // 删除setter方法前面的 “set”
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    // 将前面的字母变成小写
    NSString *lowerChar = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowerChar];
    
    if (value) {
        [mutDict setObject:value forKey:key];
    } else {
        [mutDict removeObjectForKey:key];
    }
    
    
}

id autoDictionaryGetter(id self, SEL _cmd) {
    HGMAutoDictionary *selfType = (HGMAutoDictionary *)self;
    NSMutableDictionary *mutDict = selfType.mutDict;
    
    NSString *valueKey = NSStringFromSelector(_cmd);
    return [mutDict objectForKey:valueKey];
}

@end

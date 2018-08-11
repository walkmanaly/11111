//
//  Book.m
//  11111
//
//  Created by Nick on 2018/7/12.
//  Copyright © 2018年 nick. All rights reserved.
//

#import "Book.h"

@implementation Book

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeDouble:self.pages forKey:@"pages"];
    [aCoder encodeBool:self.avilible forKey:@"avilible"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.desc = [aDecoder decodeObjectForKey:@"desc"];
    self.pages = [aDecoder decodeDoubleForKey:@"pages"];
    self.avilible = [aDecoder decodeBoolForKey:@"avilible"];
    return self;
}

@end

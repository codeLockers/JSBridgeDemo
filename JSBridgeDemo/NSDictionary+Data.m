//
//  NSDictionary+Data.m
//  JSBridgeDemo
//
//  Created by codeLocker on 2017/1/19.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#define ENCODE_KEY @""

#import "NSDictionary+Data.h"

@implementation NSDictionary (Data)

- (NSData *)encodeForKey:(NSString *)key{

    if (!self) {
        return nil;
    }
    if (!key) {
        key = ENCODE_KEY;
    }
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self forKey:key];
    [archiver finishEncoding];
    return data;
}

+ (NSDictionary *)decode:(NSData *)data forKey:(NSString *)key{

    if (!data) {
        return nil;
    }
    
    if (!key) {
        key = ENCODE_KEY;
    }
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSDictionary *dic = [unarchiver decodeObjectForKey:key];
    [unarchiver finishDecoding];

    return dic;
}

@end

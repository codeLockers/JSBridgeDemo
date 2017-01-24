//
//  NSDictionary+Data.h
//  JSBridgeDemo
//
//  Created by codeLocker on 2017/1/19.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Data)


/**
 NSDictionary -> NSData

 @param key 编码/解码的key, 类似于加密
 @return NSData
 */
- (NSData *)encodeForKey:(NSString *)key;


/**
 NSData -> NSDictionary

 @param data decode 的 data
 @param key 编码/解码的key, 类似于加密
 @return NSDictionary
 */
+ (NSDictionary *)decode:(NSData *)data forKey:(NSString *)key;

@end

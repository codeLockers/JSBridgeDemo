//
//  FCCacheManager.m
//  JSBridgeDemo
//
//  Created by codeLocker on 2017/1/24.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import "FCCacheManager.h"
#import "JKJSFileManager.h"
#import "NSDictionary+Data.h"
#import "NSString+Category.h"
#import "FCBridgeHelper.h"
#import "FCBridgeError.h"

#define CacheDir @"FCCache"
#define CacheSuffix @"archiver"

@interface FCCacheManager()

@property (nonatomic, strong) NSString *cachePath;
@end

@implementation FCCacheManager

+ (FCCacheManager *)manager{

    static FCCacheManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FCCacheManager alloc] init];
    });
    return manager;
}

- (id)init{
    
    self = [super init];
    if (self) {
        
        if (![JKJSFileManager existsItemAtPath:self.cachePath]) {
            //文件夹不存在，创建文件夹
            [JKJSFileManager createDirectoriesForPath:self.cachePath];
            
        }
    }
    return self;
}

#pragma mark - Private_Methods
/**
 判断key是否合法
 
 @param key key
 @return YES:合法 NO:不合法
 */
+ (BOOL)isKeyLegal:(NSString *)key{
    
    if (!key || key.length == 0 || [key rangeOfString:@" "].location != NSNotFound) {
        return NO;
    }
    return YES;
}

#pragma mark - Public_Methods

- (void)cacheService:(NSDictionary *)data callback:(WVJBResponseCallback)callback{

    NSString *action = data[@"action"];
    if ([action isEmpty]) {
        callback([FCBridgeHelper packageResponse:FCBridge_Action_EroCode bridgeEro_msg:FCBridge_Action_EroMsg bridge_data:nil]);
    }

    NSString *key = data[@"params"][@"key"];
    NSDictionary *value = data[@"params"][@"params"];

    if (![FCCacheManager isKeyLegal:key]) {
        callback([FCBridgeHelper packageResponse:FCBridge_Service_Cache_KeyIllegal_EroCode bridgeEro_msg:FCBridge_Service_Cache_KeyIllegal_EroMsg bridge_data:nil]);
        return;
    }
    if ([[action uppercaseString] isEqualToString:@"SET"] && !value) {
        callback([FCBridgeHelper packageResponse:FCBridge_Service_Cache_ValueIllegal_EroCode bridgeEro_msg:FCBridge_Service_Cache_ValueIllegal_EroMsg bridge_data:nil]);
        return;
    }

    if ([[action uppercaseString] isEqualToString:@"SET"]) {

        
        BOOL result = [self setCache:value forKey:key];
        if (result)
            callback([FCBridgeHelper packageResponse:FCBridge_Success_Code bridgeEro_msg:nil bridge_data:nil]);
        else
            callback([FCBridgeHelper packageResponse:FCBridge_Service_Cache_SetFail_EroCode bridgeEro_msg:FCBridge_Service_Cache_SetFail_EroMsg bridge_data:nil]);

    }else if ([[action uppercaseString] isEqualToString:@"GET"]){

        NSDictionary *cache = [self getCacheForKey:key];
        callback([FCBridgeHelper packageResponse:FCBridge_Success_Code bridgeEro_msg:nil bridge_data:cache]);
    }else{
        callback([FCBridgeHelper packageResponse:FCBridge_Action_EroCode bridgeEro_msg:FCBridge_Action_EroMsg bridge_data:nil]);
    }
}

- (BOOL)setCache:(NSDictionary *)value forKey:(NSString *)key{
    
    //cahe key 不能为空, key中不能含有空格字符串
    if (!value || ![FCCacheManager isKeyLegal:key]) {
        return NO;
    }
    
    NSString *path = [self.cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",key,CacheSuffix]];
    
    return [NSKeyedArchiver archiveRootObject:[value encodeForKey:key] toFile:path];
}

- (NSDictionary *)getCacheForKey:(NSString *)key{
    
    //key 不能为空, key中不能含有空格字符串
    if (![FCCacheManager isKeyLegal:key]) {
        return nil;
    }
    
    NSString *path = [self.cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",key,CacheSuffix]];
    NSData *data = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return [NSDictionary decode:data forKey:key];
}

- (BOOL)removeCacheForKey:(NSString *)key{
    
    //key 不能为空, key中不能含有空格字符串
    if (![FCCacheManager isKeyLegal:key]) {
        return NO;
    }
    
    NSString *path = [self.cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",key,CacheSuffix]];
    
    NSError *error = nil;
    [JKJSFileManager removeItemAtPath:path error:&error];
    
    return (error == nil);
}

- (BOOL)removeAllCache{
    
    NSError *error = nil;
    [JKJSFileManager removeItemsInDirectoryAtPath:[JKJSFileManager pathForDocumentsDirectoryWithPath:CacheDir] error:&error];
    
    return (error == nil);
}

- (NSNumber *)sizeOfCache{
    
    return [JKJSFileManager sizeOfDirectoryAtPath:[JKJSFileManager pathForDocumentsDirectoryWithPath:CacheDir]];
    
}

#pragma mark - Setter && Getter
- (NSString *)cachePath{
    
    if (!_cachePath) {
#warning userid 需要替换成实际用户的ID
        _cachePath = [JKJSFileManager pathForDocumentsDirectoryWithPath:[NSString stringWithFormat:@"%@/userid",CacheDir]];
    }
    return _cachePath;
}

@end

//
//  FCCacheManager.h
//  JSBridgeDemo
//
//  Created by codeLocker on 2017/1/24.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>

@interface FCCacheManager : NSObject

+ (FCCacheManager *)manager;

- (void)cacheService:(NSDictionary *)data callback:(WVJBResponseCallback)callback;

/**
 保存cache
 
 @param value 需要保存的cache对象
 @param key 保存的key
 @return YES:保存成功 NO:保存失败
 */
- (BOOL)setCache:(NSDictionary *)value forKey:(NSString *)key;


/**
 获取cache
 
 @param key 保存的key
 @return NSDictionary
 */
- (NSDictionary *)getCacheForKey:(NSString *)key;


/**
 删除某一key对应的缓存
 
 @param key 对应的key
 @return YES:删除成功 NO:删除失败
 */
- (BOOL)removeCacheForKey:(NSString *)key;


/**
 清除所有的缓存
 
 @return YES:删除成功 NO:删除失败
 */
- (BOOL)removeAllCache;


/**
 获取缓存大小
 
 @return 缓存大小
 */
- (NSNumber *)sizeOfCache;


/**
 存储使用的key是否合法
 
 @param key key
 @return YES:合法 NO:不合法
 */
+ (BOOL)isKeyLegal:(NSString *)key;
@end

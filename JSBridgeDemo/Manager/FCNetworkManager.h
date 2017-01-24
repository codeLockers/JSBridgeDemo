//
//  FCNetworkManager.h
//  JSBridgeDemo
//
//  Created by codeLocker on 2017/1/24.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>

@interface FCNetworkManager : NSObject

+ (FCNetworkManager *)manager;

- (void)networkService:(NSDictionary *)data callback:(WVJBResponseCallback)callback;;

/**
 *  post请求
 *
 *  @param url        请求url
 *  @param params     请求参数
 *  @param completion 请求完成回调
 */
- (void)postWithUrl:(NSString *)url params:(NSDictionary *)params callback:(void(^)(NSDictionary *response, NSString *error))completion;
/**
 *  get请求
 *
 *  @param url        请求URL
 *  @param params     请求参数
 *  @param completion 请求完成回调
 */
- (void)getWithUrl:(NSString *)url params:(NSDictionary *)params callback:(void(^)(NSDictionary *response, NSString *error))completion;

/**
 *  put请求
 *
 *  @param url        请求URL
 *  @param params     请求参数
 *  @param completion 请求完成回调
 */
- (void)putWithUrl:(NSString *)url params:(NSDictionary *)params callback:(void(^)(NSDictionary *response, NSString *error))completion;


/**
 *  delete请求
 *
 *  @param url        请求URL
 *  @param params     请求参数
 *  @param completion 请求完成回调
 */
- (void)deleteWithUrl:(NSString *)url params:(NSDictionary *)params callback:(void(^)(NSDictionary *response, NSString *error))completion;

@end

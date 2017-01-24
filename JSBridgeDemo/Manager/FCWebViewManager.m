//
//  FCWebViewManager.m
//  JSBridgeDemo
//
//  Created by codeLocker on 2017/1/24.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import "FCWebViewManager.h"
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
#import "NSString+Category.h"
#import "FCNetworkManager.h"
#import "FCBridgeHelper.h"
#import "FCCacheManager.h"
#import "FCBridgeError.h"

@interface FCWebViewManager()

@property (nonatomic, strong) WebViewJavascriptBridge *bridge;

@end

@implementation FCWebViewManager


- (id)initWithFrame:(CGRect)frame url:(NSString *)urlStr{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpWithUrl:urlStr];
    }
    return self;
}

- (void)setUpWithUrl:(NSString *)urlStr{
    
    NSURL *url = [NSURL URLWithString:urlStr];
    [self loadRequest:[NSURLRequest requestWithURL:url]];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self];
    __weak typeof(self) weakSelf = self;
    //注册方法
    [self.bridge registerHandler:@"requestService" handler:^(id data, WVJBResponseCallback responseCallback) {
        //处理JS需要的服务
        [weakSelf handlerServiceWithData:data callback:responseCallback];
        
    }];
}

/**
 处理JS所需要的服务
 
 @param data JS出给Native的参数
 @param callback JS回调
 */
- (void)handlerServiceWithData:(NSDictionary *)data callback:(WVJBResponseCallback)callback{
    
    NSString *service = data[@"service"];
    
    if ([service isEmpty]) {
        //空服务
        callback([FCBridgeHelper packageResponse:FCBridge_Service_EroCode bridgeEro_msg:FCBridge_Service_EroMsg bridge_data:nil]);
        return;
        
    }else if ([service isEqualToString:@"JKJS.http"] || [service isEqualToString:@"JKJS.https"]){
        
        //网络请求服务
        [[FCNetworkManager manager] networkService:data callback:callback];
        
    }else if ([service isEqualToString:@"JKJS.cache"]){
        
        //缓存服务
        [[FCCacheManager manager] cacheService:data callback:callback];
        
    }else{
        callback([FCBridgeHelper packageResponse:FCBridge_Service_EroCode bridgeEro_msg:FCBridge_Service_EroMsg bridge_data:nil]);
    }
}


@end

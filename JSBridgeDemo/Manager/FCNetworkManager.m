
//
//  FCNetworkManager.m
//  JSBridgeDemo
//
//  Created by codeLocker on 2017/1/24.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import "FCNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "NSString+Category.h"
#import "FCBridgeHelper.h"
#import "FCBridgeError.h"

@interface FCNetworkManager(){
    
    AFHTTPSessionManager *_manager;
}

@end

@implementation FCNetworkManager

+ (FCNetworkManager *)manager{

    static FCNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FCNetworkManager alloc] init];
    });
    return manager;
}

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        _manager = [AFHTTPSessionManager manager];
        [_manager.requestSerializer setTimeoutInterval:10.f];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    }
    
    return self;
}

#pragma mark - 
- (void)networkService:(NSDictionary *)data callback:(WVJBResponseCallback)callback{

    NSString *action = data[@"action"];
    if ([action isEmpty]) {
        callback([FCBridgeHelper packageResponse:FCBridge_Action_EroCode bridgeEro_msg:FCBridge_Action_EroMsg bridge_data:nil]);
        return;
    }
    
    NSString *api = data[@"params"][@"api"];
    if ([api isEmpty]) {
        //请求的api为空
        callback([FCBridgeHelper packageResponse:FCBridge_Service_Network_EmptyApi_EroCode bridgeEro_msg:FCBridge_Service_Network_EmptyApi_EroMsg bridge_data:nil]);
        return;
    }
    
    
    
    if ([[action uppercaseString] isEqualToString:@"POST"]) {
        //post
        [self postWithUrl:api params:data[@"params"][@"params"] callback:^(NSDictionary *response, NSString *error) {
            
            if (error) {
                //请求失败
                callback([FCBridgeHelper packageResponse:FCBridge_Service_Network_Abnormal_EroCode bridgeEro_msg:FCBridge_Service_Network_Abnormal_EroMsg bridge_data:nil]);
                
            }else{
                //请求成功
                callback([FCBridgeHelper packageResponse:FCBridge_Success_Code bridgeEro_msg:nil bridge_data:response]);
            }
        }];
        
    }else if ([[action uppercaseString] isEqualToString:@"GET"]){
        //get
        [self getWithUrl:api params:data[@"params"][@"params"] callback:^(NSDictionary *response, NSString *error) {
            
            if (error) {
                //请求失败
                callback([FCBridgeHelper packageResponse:FCBridge_Service_Network_Abnormal_EroCode bridgeEro_msg:FCBridge_Service_Network_Abnormal_EroMsg bridge_data:nil]);
            }else{
                //请求成功
                callback([FCBridgeHelper packageResponse:FCBridge_Success_Code bridgeEro_msg:nil bridge_data:response]);
            }
        }];
        
    }else if ([[action uppercaseString] isEqualToString:@"PUT"]){
        //put
        [self putWithUrl:api params:data[@"params"][@"params"] callback:^(NSDictionary *response, NSString *error) {
            if (error) {
                //请求失败
                callback([FCBridgeHelper packageResponse:FCBridge_Service_Network_Abnormal_EroCode bridgeEro_msg:FCBridge_Service_Network_Abnormal_EroMsg bridge_data:nil]);
            }else{
                //请求成功
                callback([FCBridgeHelper packageResponse:FCBridge_Success_Code bridgeEro_msg:nil bridge_data:response]);
            }
        }];
        
    }else if ([[action uppercaseString] isEqualToString:@"DELETE"]){
        //delete
        [self deleteWithUrl:api params:data[@"params"][@"params"] callback:^(NSDictionary *response, NSString *error) {
            
            if (error) {
                //请求失败
                callback([FCBridgeHelper packageResponse:FCBridge_Service_Network_Abnormal_EroCode bridgeEro_msg:FCBridge_Service_Network_Abnormal_EroMsg bridge_data:nil]);
            }else{
                //请求成功
                callback([FCBridgeHelper packageResponse:FCBridge_Success_Code bridgeEro_msg:nil bridge_data:response]);
            }
        }];
    }else{
        callback([FCBridgeHelper packageResponse:FCBridge_Action_EroCode bridgeEro_msg:FCBridge_Action_EroMsg bridge_data:nil]);
    }

}

#pragma mark - Network_Methods
- (void)postWithUrl:(NSString *)url params:(NSDictionary *)params callback:(void(^)(NSDictionary *response, NSString *error))completion{
    
    if (!params) {
        params = [NSDictionary dictionary];
    }
    
    [_manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, @"error");
    }];
}

- (void)getWithUrl:(NSString *)url params:(NSDictionary *)params callback:(void(^)(NSDictionary *response, NSString *error))completion{
    
    
    if (!params) {
        params = [NSDictionary dictionary];
    }
    
    [_manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        completion(nil, @"error");
    }];
    
}

- (void)putWithUrl:(NSString *)url params:(NSDictionary *)params callback:(void(^)(NSDictionary *response, NSString *error))completion{
    
    if (!params) {
        params = [NSDictionary dictionary];
    }
    
    [_manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, @"error");
    }];
    
}


- (void)deleteWithUrl:(NSString *)url params:(NSDictionary *)params callback:(void(^)(NSDictionary *response, NSString *error))completion{
    
    if (!params) {
        params = [NSDictionary dictionary];
    }
    
    [_manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, @"error");
    }];
    
}

@end

//
//  FCBridgeHelper.m
//  JSBridgeDemo
//
//  Created by codeLocker on 2017/1/24.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import "FCBridgeHelper.h"

@implementation FCBridgeHelper

+ (NSDictionary *)packageResponse:(NSString *)bridgeEro_code bridgeEro_msg:(NSString *)bridgeEro_msg bridge_data:(NSDictionary *)bridge_data{
    
    NSAssert(bridgeEro_code, @"FCBridgeHelper packageResponse bridgeEro_code can't be nil");
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:bridgeEro_code forKey:@"bridgeEro_code"];
    
    bridgeEro_msg ? [dic setObject:bridgeEro_msg forKey:@"bridgeEro_msg"] : [dic setObject:[NSNull null] forKey:@"bridgeEro_msg"];
    bridge_data ? [dic setObject:bridge_data forKey:@"bridge_data"] : [dic setObject:[NSNull null] forKey:@"bridge_data"];
    
    return [dic copy];
}

@end

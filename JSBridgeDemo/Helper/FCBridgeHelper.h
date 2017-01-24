//
//  FCBridgeHelper.h
//  JSBridgeDemo
//
//  Created by codeLocker on 2017/1/24.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCBridgeHelper : NSObject

/**
 包装需要返回个Web的数据，结构中的错误码，错误信息只涉及到桥接的成功失败与否，具体的需要的数据是否正确不做任何判断处理，统一抛给Web端处理

 @param bridgeEro_code 错误码 0:成功
 @param bridgeEro_msg 错误信息 bridgeEro_code == 0 的情况下为空
 @param bridge_data 返回的数据 bridgeEro_code != 0 的情况下为空
 @return 包装好的数据格式
 */
+ (NSDictionary *)packageResponse:(NSString *)bridgeEro_code bridgeEro_msg:(NSString *)bridgeEro_msg bridge_data:(NSDictionary *)bridge_data;

@end

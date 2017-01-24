//
//  FCBridgeError.h
//  JSBridgeDemo
//
//  Created by codeLocker on 2017/1/24.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#ifndef FCBridgeError_h
#define FCBridgeError_h
//=====================
#pragma mark - Success
#define FCBridge_Success_Code @"100"

//=====================
#pragma mark - Service
#define FCBridge_Service_EroCode @"101"
#define FCBridge_Service_EroMsg @"所请求的服务出错"

//=====================
#define FCBridge_Action_EroCode @"102"
#define FCBridge_Action_EroMsg @"所请求的action出错"

//=====================
#pragma mark - Service_Network
#define FCBridge_Service_Network_EmptyApi_EroCode @"201"
#define FCBridge_Service_Network_EmptyApi_EroMsg @"网络服务api字段为空"

#define FCBridge_Service_Network_Abnormal_EroCode @"202"
#define FCBridge_Service_Network_Abnormal_EroMsg @"网络服务网络异常"

//=====================
#pragma mark - Service_Cache
#define FCBridge_Service_Cache_KeyIllegal_EroCode @"301"
#define FCBridge_Service_Cache_KeyIllegal_EroMsg  @"缓存服务key不合法"
#define FCBridge_Service_Cache_ValueIllegal_EroCode @"302"
#define FCBridge_Service_Cache_ValueIllegal_EroMsg  @"缓存服务Value不合法"
#define FCBridge_Service_Cache_SetFail_EroCode @"303"
#define FCBridge_Service_Cache_SetFail_EroMsg @"缓存存储失败"

#endif /* FCBridgeError_h */

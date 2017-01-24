//
//  NSString+Category.m
//  JSBridgeDemo
//
//  Created by codeLocker on 2017/1/22.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

- (BOOL)isEmpty{

    return (self == nil || self.length == 0);
}
@end

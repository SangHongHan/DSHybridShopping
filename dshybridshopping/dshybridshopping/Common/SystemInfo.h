//
//  SystemInfo.h
//  DSHybridSDK
//
//  Created by HanSanghong on 2016. 8. 2..
//  Copyright © 2019년 Directionsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemInfo : NSObject

+ (NSString *)getDeviceName;
+ (NSString *)platform;
+ (NSString *)getCurrierName;
+ (NSString *)getDeviceOS;
+ (NSString *)getOSVersion;
+ (NSString *)getOrientation;
+ (BOOL)IsNetworkUnAvailable;

@end

//
//  PermissionManager.h
//  DSHybridSDK
//
//  Created by Tommy Kim on 2019. 1. 22..
//  Copyright directionsoft. All rights reserved.
//

/*
 plist의 접근 권한을 추가해 줘야 AppStore에 올라감을 주의할것.
*/

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define IPermissionManager [PermissionManager sharedInstance]

typedef NS_ENUM(NSInteger, PermissionTypes)
{
    PermissionTypeContact,
    PermissionTypeMic,
    PermissionTypeCamera,
    PermissionTypeAlbum,
    PermissionTypeCalendar,
    PermissionTypeLocation,
    PermissionTypeBioId // FaceId or TouchId
};

typedef NS_ENUM(NSInteger, PermissionState)
{
    PermissionStateFirst,
    PermissionStateAgree,
    PermissionStatedisAgree,
};


@interface PermissionManager : NSObject

+ (PermissionManager *)sharedInstance;

+ (PermissionState)getPermissionState:(PermissionTypes)type;
+ (void)requestPermission:(PermissionTypes)type completionHandler:(void(^)(BOOL granted))completionHandler;
+ (void)tryBiometricsAuthentication:(NSString*)localizedReason success:(void (^)(void))callback fail:(void (^)(NSInteger))failCallback;

@end

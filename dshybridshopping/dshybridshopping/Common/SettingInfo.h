//
//  SettingInfo.h
//  GHybridSDK
//
//  Created by Sanghong Han on 2019/12/04.
//  Copyright © 2019 directionsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingInfo : NSObject

@property (nonatomic, strong) NSString *loginName;
@property (nonatomic, assign) BOOL isPushEnabled;
@property (nonatomic, assign) BOOL isPushBuyEnabled;
@property (nonatomic, assign) BOOL isNeedUpdate;
@property (nonatomic, strong) NSString *sLocalVersion;
@property (nonatomic, strong) NSString *sServerVersion;
@property (nonatomic, strong) NSString *sAppStoreURL;

+ (SettingInfo *)sharedInstance;

@end

NS_ASSUME_NONNULL_END

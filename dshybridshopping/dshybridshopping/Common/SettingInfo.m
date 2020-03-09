//
//  SettingInfo.m
//  GHybridSDK
//
//  Created by Sanghong Han on 2019/12/04.
//  Copyright © 2019 directionsoft. All rights reserved.
//

#import "SettingInfo.h"

@implementation SettingInfo

#pragma mark - Create Singletone

+ (SettingInfo *)sharedInstance{
    static SettingInfo *settingInfo = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        settingInfo = [[super alloc] init];
        
    });
    
    return settingInfo;
}

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}


@end

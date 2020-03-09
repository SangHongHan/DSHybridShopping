//
//  SDKInfo.m
//  GHybridSDK
//
//  Created by Sanghong Han on 2019/11/23.
//  Copyright © 2019 directionsoft. All rights reserved.
//

#import "SDKInfo.h"

@implementation SDKInfo

#pragma mark - Create Singletone

+ (SDKInfo *)sharedInstance{
    static SDKInfo *sdkInfo = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sdkInfo = [[super alloc] init];
        
    });
    
    return sdkInfo;
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

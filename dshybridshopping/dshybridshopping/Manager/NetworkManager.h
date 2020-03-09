//
//  NetworkManager.h
//  GHybridSDK
//
//  Created by SangHong Han on 2018. 3. 20..
//  Copyright © 2018년 directionsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define kTimeOut    5

NS_ASSUME_NONNULL_BEGIN

typedef void (^successBlock)(NSDictionary * __nullable response);
typedef void (^failureBlock)(NSError * __nullable error);

#define _successBlock       successBlock _Nullable
#define _failureBlock       failureBlock _Nullable

@interface NetworkManager : AFHTTPSessionManager

+ (void)sendRequest:(NSString *)urlString parameters:(NSDictionary *)params success:(void (^)(NSDictionary *response))success failure:(void (^)(NSError * __nonnull))failure;

@end

NS_ASSUME_NONNULL_END

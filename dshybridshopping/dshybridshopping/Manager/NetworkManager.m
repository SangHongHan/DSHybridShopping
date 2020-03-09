//
//  NetworkManager.m
//  OSEBaseApp
//
//  Created by seoyeon on 2018. 3. 20..
//  Copyright © 2018년 directionsoft. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

+ (AFHTTPSessionManager *)getManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithArray:@[@"text/html", @"text/json",@"text/plain", @"application/json"]]];
    
    return manager;
}

+ (instancetype)defaultManager {
    NSString* baseURL = @"http://m.daum.net";
    
    static NetworkManager * _defaultManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultManager = [[NetworkManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
        _defaultManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _defaultManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [_defaultManager.responseSerializer setAcceptableContentTypes:[NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"application/json"]]];
        
        [_defaultManager.requestSerializer setTimeoutInterval:kTimeOut];
        [_defaultManager.requestSerializer setValue:@"GALLERIA_MOBILE_IPHONE" forHTTPHeaderField:@"User-Agent"];
        
        ((AFJSONResponseSerializer *)_defaultManager.responseSerializer).readingOptions = NSJSONReadingAllowFragments;
        
        [_defaultManager.reachabilityManager startMonitoring];
    });
    
    return _defaultManager;
}

+ (void)sendRequest:(NSString *)urlString parameters:(NSDictionary *)params success:(void (^)(NSDictionary *response))success failure:(void (^)(NSError * __nonnull))failure {
    
    AFHTTPSessionManager *manager = [self defaultManager];
    
    NSString *url = urlString;

    [manager GET:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            if (success) {
                success(dic);
            }
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end

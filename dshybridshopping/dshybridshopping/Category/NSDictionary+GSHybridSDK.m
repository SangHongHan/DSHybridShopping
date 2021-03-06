//
//  NSDictionary+GHybridSDK.m
//  GHybridSDK
//
//  Created by HanSanghong on 2016. 8. 8..
//  Copyright © 2019년 Directionsoft. All rights reserved.
//

#import "NSDictionary+GHybridSDK.h"

@implementation NSDictionary (GHybridSDK)

- (NSString *)convertJSONString
{
    NSError *err = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&err];
    if (err) {
        NSString *sResult =  @"{\"code\":-100, \"result\":\"%@\"}";
        return [NSString stringWithFormat:sResult, [err localizedDescription]];
    }
    else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end

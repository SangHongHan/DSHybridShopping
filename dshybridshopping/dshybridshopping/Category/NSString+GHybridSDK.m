//
//  NSString+GHybridSDK.m
//  GHybridSDK
//
//  Created by HanSanghong on 2016. 7. 14..
//  Copyright © 2019년 Directionsoft. All rights reserved.
//

#import "NSString+GHybridSDK.h"

#define documentPath    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@implementation NSString (GHybridSDK)

//- (NSDictionary *)parseURLParams {
//    NSArray *pairs = [self componentsSeparatedByString:@"&"];
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    for (NSString *pair in pairs) {
//        NSArray *kv = [pair componentsSeparatedByString:@"="];
//        if ([kv count] == 2) {
//            NSString *val = kv[1];
//            params[kv[0]] = val;
//        }
//
//    }
//    return params;
//}

- (NSData *)dataValue
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSDictionary *)parseURLFuncParams {
    NSUInteger nLoc = [self rangeOfString:@"&"].location;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (nLoc != NSNotFound) {
        NSString *strFunc = [self substringToIndex:nLoc];
        NSString *strParam = [self substringFromIndex:nLoc+1];
        NSUInteger nLoc = [strFunc rangeOfString:@"="].location;
        if (nLoc != NSNotFound) {
            NSString *key = [strFunc substringToIndex:nLoc];
            NSString *val = [strFunc substringFromIndex:nLoc+1];
            params[key] = val;
        }
        nLoc = [strParam rangeOfString:@"="].location;
        if (nLoc != NSNotFound) {
            NSString *key = [strParam substringToIndex:nLoc];
            NSString *val = [strParam substringFromIndex:nLoc+1];
            params[key] = val;
        }
    }else {
        params = [NSMutableDictionary dictionaryWithDictionary:[self parseURLParams]];
    }
        
    return params;
}

- (NSDictionary *)parseURLParams {
    NSArray *pairs = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSUInteger nLoc = [pair rangeOfString:@"="].location;
        if (nLoc != NSNotFound) {
            NSString *key = [pair substringToIndex:nLoc];
            NSString *val = [[pair substringFromIndex:nLoc+1] stringByRemovingPercentEncoding];
            params[key] = val;
        }
    }
    return params;
}

@end

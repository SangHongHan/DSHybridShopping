//
//  NSDate+GHybridSDK.m
//  GHybridSDK
//
//  Created by HanSanghong on 2016. 8. 25..
//  Copyright © 2019년 Directionsoft. All rights reserved.
//

#import "NSDate+GHybridSDK.h"

@implementation NSDate (GHybridSDK)

- (NSInteger)CompareFromNow
{
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];
    return (int)[midnight timeIntervalSinceNow] / (60*60*24);
}

- (NSString *)yyyymmdd
{
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
    [mdf setDateFormat:@"yyyyMMdd"];
    
    return [mdf stringFromDate:self];
}

- (NSString *)hhmmss
{
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
    [mdf setDateFormat:@"HHmmss"];
    
    return [mdf stringFromDate:self];
}

- (int)dd
{
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
    [mdf setDateFormat:@"dd"];
    
    return [[mdf stringFromDate:self] intValue];
}

- (NSString *)todayStr:(NSString *)sFormat
{
    NSDateFormatter *dFormater = [[NSDateFormatter alloc] init];
    dFormater.dateFormat = sFormat;
    return [dFormater stringFromDate:self];
}

@end

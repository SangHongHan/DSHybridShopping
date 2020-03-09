//
//  NSDate+GHybridSDK.h
//  GHybridSDK
//
//  Created by HanSanghong on 2016. 8. 25..
//  Copyright © 2019년 Directionsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GHybridSDK)

- (NSInteger)CompareFromNow;

//오늘날짜의 형식을 20191112 형태로 리턴
- (NSString *)yyyymmdd;

//현재시간의 형식을 142424 형태로 리턴
- (NSString *)hhmmss;

//오늘날짜만 리턴
- (int)dd;

//날짜를 주어진 sFormat의 문자열로 변환
- (NSString *)todayStr:(NSString *)sFormat;

@end

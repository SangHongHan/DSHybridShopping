//
//  NSString+GHybridSDK.h
//  GHybridSDK
//
//  Created by HanSanghong on 2016. 7. 14..
//  Copyright © 2019년 Directionsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GHybridSDK)

- (NSDictionary *)parseURLFuncParams;
//a=b&c=d 형태의 문자열을 NSDictionary로 변환
- (NSDictionary *)parseURLParams;

//NSString 값을 NSData 타입으로 변환
- (NSData *)dataValue;

@end

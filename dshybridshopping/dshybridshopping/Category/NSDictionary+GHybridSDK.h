//
//  NSDictionary+GHybridSDK.h
//  GHybridSDK
//
//  Created by HanSanghong on 2016. 8. 8..
//  Copyright © 2019년 Directionsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (GHybridSDK)

//NSDictionary 데이터를 JSON 문자열로 변경
//에러인 경우 {"code: -100, result: "error message"} 형태로 리턴
- (NSString *)convertJSONString;

@end

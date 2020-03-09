//
//  SDKInfo.h
//  GHybridSDK
//
//  Created by Sanghong Han on 2019/11/23.
//  Copyright © 2019 directionsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDKInfo : NSObject

/*!
    앱이 구동 후 호출할 웹 URL
    이 값이 설정되어 있지 않으면 앱을 종료.
*/
@property (nonatomic, strong) NSString *startPage;
/*!
    버전 업데이트 체크, 인트로 이미지 가져오기 등 서버로부터 데이터를 받기 위해서 사용되는 서버 API URL
    이 값이 설정되어 있지 않은 경우 버전체크 및 인트로 이미지 가져오기 동작하지 않음.
*/
@property (nonatomic, strong) NSString *apiUrl;
/*!
    이 라이브러리를 사용하기 위해서 필요한 앱용 Key
    이 값이 없거나 유효하지 않은 경우 앱 종료됨. 단 Simulator 인 경우에는 정상 동작 함.
*/
@property (nonatomic, strong) NSString *appkey;
/*!
    모바일웹에서 사용자가 앱으로 접속했는지를 판단하기 위한 용도로 userAgent를 사용
    기존 UserAgent에 userAgent 값을 추가
*/
@property (nonatomic, strong) NSString *userAgent;
/*!
    모바일웹에서 앱으로 데이터를 전달하기 위해서 정의한 프로토콜
    기본적오르 dsshopping:// 이라고 하는 scheme을 사용함.
*/
@property (nonatomic, strong) NSString *appscheme;
/*!
    앱 실행시 서버로부터 인트로 이미지를 받아서 사용할 것인지를 지정
    이 값이 true인 경우에만 인트로 사용
*/
@property (nonatomic, assign) BOOL showIntro;

+ (SDKInfo *)sharedInstance;

@end

NS_ASSUME_NONNULL_END

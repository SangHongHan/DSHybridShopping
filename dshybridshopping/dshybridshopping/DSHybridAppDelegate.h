//
//  DSHybridAppDelegate.h
//  dshybridshopping
//
//  Created by Sanghong Han on 2019/11/12.
//  Copyright © 2019 directionsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSHybridAppDelegate : UIResponder  <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) NSString *pushUrl;


/**
    - 앱을 종료하기 위한 메소드
    - parameter 없음
 */
- (void)AppExit;

@end

NS_ASSUME_NONNULL_END

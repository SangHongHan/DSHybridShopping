//
//  dshybridshopping.h
//  dshybridshopping
//
//  Created by Sanghong Han on 2020/03/02.
//  Copyright © 2020 directionsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for dshybridshopping.
FOUNDATION_EXPORT double dshybridshoppingVersionNumber;

//! Project version string for dshybridshopping.
FOUNDATION_EXPORT const unsigned char dshybridshoppingVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <dshybridshopping/PublicHeader.h>


#import "DSHybridAppDelegate.h"
#import "SDKInfo.h"
#import "SettingInfo.h"

//Notification Constant
#define kLogoutNotification @"LogoutNotification"
#define kLoginNotification @"LoginNotification"
#define kShowAlarmNotification @"ShowAlarmNotification"

// API List
#define API_INTRO @"/app/splashImg.action"
#define API_VERSIONCHECK @"/app/versionCheck.action"

//기본 Define

#define kFrameworkName                  @"DSHybridShopping 프레임워크"
#define kFramworkBundle                 @"com.directionsoft.framework.dshybridshopping"
#define ABBundle                        [[NSBundle mainBundle] infoDictionary]
#define APPVERSION                      [ABBundle objectForKey:@"CFBundleShortVersionString"]

#define kScreenBoundsWidth              [[UIScreen mainScreen] bounds].size.width
#define kScreenBoundsHeight             [[UIScreen mainScreen] bounds].size.height

#define UserDefaults                    [NSUserDefaults standardUserDefaults]

#define StartY  [[UIApplication sharedApplication] statusBarFrame].size.height
#define     UIColorFromRGB(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  \
                                                            green:((float)((rgbValue & 0xFF00) >> 8))/255.0     \
                                                            blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define     UIColorFromRGBA(rgbValue, a)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  \
                                                            green:((float)((rgbValue & 0xFF00) >> 8))/255.0     \
                                                            blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

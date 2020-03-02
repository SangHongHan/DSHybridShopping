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

#define kFrameworkName                  @"DSHybridShopping 프레임워크"
#define kFramworkBundle                 @"com.directionsoft.framework.dshybridshopping"
#define ABBundle                        [[NSBundle mainBundle] infoDictionary]
#define APPVERSION                      [ABBundle objectForKey:@"CFBundleShortVersionString"]

#define kScreenBoundsWidth              [[UIScreen mainScreen] bounds].size.width
#define kScreenBoundsHeight             [[UIScreen mainScreen] bounds].size.height

#define UserDefaults                    [NSUserDefaults standardUserDefaults]

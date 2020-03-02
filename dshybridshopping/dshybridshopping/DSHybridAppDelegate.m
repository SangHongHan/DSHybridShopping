//
//  DSHybridAppDelegate.m
//  DSHybridSDK
//
//  Created by Sanghong Han on 2019/11/12.
//  Copyright © 2019 directionsoft. All rights reserved.
//

#import "DSHybridAppDelegate.h"
#import "dshybridshopping.h"

@interface DSHybridAppDelegate()
{
    
}

@end

@implementation DSHybridAppDelegate


#pragma mark - lifecycle function

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSDictionary *dictInfoKey = [ABBundle objectForKey:@"DSHybridShopping"];
    if (dictInfoKey == nil) {
        [NSException raise:kFrameworkName format:@"%@", @"info.plist에 DSHybridShopping키가 존재해야 합니다."];
        return NO;
    }
    
    //Appkey
    if (!dictInfoKey[@"AppKey"] || [dictInfoKey[@"AppKey"] isEqualToString:@""]) {
        [NSException raise:kFrameworkName format:@"%@", @"DSHybridShopping키에 StartPage가 존재하지 않거나 값이 없습니다."];
        return NO;
    }
    
    //시작페이지
    if (!dictInfoKey[@"StartPage"] || [dictInfoKey[@"StartPage"] isEqualToString:@""]) {
        [NSException raise:kFrameworkName format:@"%@", @"DSHybridShopping키에 StartPage가 존재하지 않거나 값이 없습니다."];
        return NO;
    }
    
    //앱연동 스킴명
    if (!dictInfoKey[@"AppScheme"] || [dictInfoKey[@"AppScheme"] isEqualToString:@""]) {
        [NSException raise:kFrameworkName format:@"%@", @"DSHybridShopping키에 AppScheme이 존재하지 않거나 값이 없습니다."];
        return NO;
    }
    
    //API URL
    if (!dictInfoKey[@"ApiUrl"] || [dictInfoKey[@"ApiUrl"] isEqualToString:@""]) {
        [NSException raise:kFrameworkName format:@"%@", @"DSHybridShopping키에 ApiUrl이 존재하지 않거나 값이 없습니다."];
        return NO;
    }
    
    // 윈도우 생성
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    self.mainController = [[MainViewController alloc] init];
//    self.window.rootViewController = self.mainController;
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
 
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

#pragma mark - Public Method

- (void)AppExit
{
    UIApplication *app = [UIApplication sharedApplication];
    [app performSelector:@selector(suspend)];
    [NSThread sleepForTimeInterval:0.5];
    exit(0);
}

@end

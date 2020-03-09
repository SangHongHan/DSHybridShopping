//
//  xFrame5WebView.h
//  DSHybridSDK
//
//  Created by Sanghong Han on 2019/11/08.
//  Copyright © 2019 Directionsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WKProcessPool.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebViewPoolHandler : NSObject
{
}
+ (WKProcessPool *)pool;
@end

@protocol DSHybridWebViewDelegate <NSObject>

@optional
- (void)showToastMessage:(NSDictionary *)dict;
- (void)openSettingView;
- (void)showAlarmList;
- (void)phonecall:(NSDictionary *)dict;
- (void)sendEmail:(NSDictionary *)dict;
- (void)doLogout;

@end

@interface DSHybridWebView : UIView

@property (nonatomic, assign) id<DSHybridWebViewDelegate> delegate;
@property (nonatomic, strong) NSString *appSchemeName;

- (void)callJavaScript:(NSString *)aScript;
- (void)loadRequest:(NSURLRequest *)request;
- (void)loadWebURL:(NSString *)aUrl;
- (void)setCookieNew:(NSHTTPCookie *)dictCookie;

@end

NS_ASSUME_NONNULL_END

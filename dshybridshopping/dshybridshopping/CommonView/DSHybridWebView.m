//
//  xFrame5WebView.m
//  xFrame5
//
//  Created by Sanghong Han on 2019/11/08.
//  Copyright © 2019 softbase. All rights reserved.
//

#import "DSHybridWebView.h"
#import "DSHybridAppDelegate.h"

#import "dshybridshopping.h"
#import "NSString+GHybridSDK.h"
#import "CommonAlertView.h"
#import "SystemInfo.h"

#import <WebKit/WebKit.h>

@interface DSHybridWebView() <WKUIDelegate, WKNavigationDelegate>
{
    BOOL isFinished;
}

@property (nonatomic, strong) WKWebView *wkWeb;
@property (nonatomic, strong) NSMutableArray <WKWebView *> *arrWebView;

@end

@implementation WKWebViewPoolHandler

+ (WKProcessPool *) pool
{
    static dispatch_once_t onceToken;
    static WKProcessPool *_pool;
    dispatch_once(&onceToken, ^{
        _pool = [[WKProcessPool alloc] init];
    });
    return _pool;
}

@end

@implementation DSHybridWebView

- (NSString *)getTmsNo:(NSString *)sMbrNo
{
    return @"";
}

- (void)appschemeProcess:(NSURL *)aUrl
{
    if ([aUrl.host.lowercaseString isEqualToString:@"alarm"]) {
        [self.delegate showAlarmList];
    }
    else if ([aUrl.host.lowercaseString isEqualToString:@"setting"]) {
         [self.delegate openSettingView];
    }
    else if ([aUrl.host.lowercaseString isEqualToString:@"logout"]) {
         [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"userName"];
         [[NSUserDefaults standardUserDefaults] synchronize];
         [SettingInfo sharedInstance].loginName = @"";
    }
    else if ([aUrl.host.lowercaseString isEqualToString:@"login"]) {
        NSString *aQuery = aUrl.query;
        NSDictionary *dictParams = [aQuery parseURLParams];
        NSLog(@"dictParams is %@", dictParams);
        /*
            adtYn = N;
            isAutoLogin = N;
            seqNo = "MjkyMDE5MTIxMDAyMzc1MDQ2MzU=";
            userName = "\Uae40\Ubcd1\Uc8fc";
         */
        NSString *sUserName = dictParams[@"username"];
        if (!sUserName || [sUserName isEqualToString:@""]) {
            sUserName = dictParams[@"userName"];
        }
        
        [[NSUserDefaults standardUserDefaults] setValue:sUserName forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [SettingInfo sharedInstance].loginName = sUserName;
    }
    else if ([aUrl.host.lowercaseString isEqualToString:@"outlink"] ) {
        NSString *aQuery = aUrl.query;
        NSDictionary *dictParams = [aQuery parseURLParams];
        if (dictParams[@"url"] && ![dictParams[@"url"] isEqualToString:@""]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dictParams[@"url"]]
                                               options:@{}
                                     completionHandler:^(BOOL success) {
            }];
        }
    }
}

#pragma mark - WKWebView WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:webView.URL.host message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        completionHandler();
    }]];
    
    [((DSHybridAppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    dispatch_async(dispatch_get_main_queue(),^{

        // TODO We have to think message to confirm "YES"
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:webView.URL.host message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            completionHandler(YES);
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            completionHandler(NO);
        }]];
        [alertController.view setNeedsLayout];
        
        [((DSHybridAppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:webView.URL.host preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.text = defaultText;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *input = ((UITextField *)alertController.textFields.firstObject).text;
        completionHandler(input);
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        completionHandler(nil);
    }]];
    
    [((DSHybridAppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - WKWebView Delegate

- (void)showNetworkError
{
    CommonAlertView *alert = [[CommonAlertView alloc] init];
    [alert showCustomAlertView:nil
                         title:@""
                       message:@"네트워크 오류가 발생하였습니다.\n잠시 후에 다시 시도해 주세요."
             cancelButtonTitle:nil
                 okButtonTitle:@"종료"];
    alert.okClick = ^{
       dispatch_async(dispatch_get_main_queue(), ^{
            [(DSHybridAppDelegate *)[[UIApplication sharedApplication] delegate] AppExit];
        });
    };
}

//팝업 기능 사용을 원할 시 고려해볼 부분
- (WKWebView *)webView:(WKWebView *)webView
createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    
    WKWebView *newWebView = [[WKWebView alloc] initWithFrame:self.wkWeb.frame configuration:configuration];
    newWebView.navigationDelegate = self;
    newWebView.UIDelegate = self;
    [self addSubview:newWebView];
    [self.arrWebView addObject:newWebView];

    return newWebView;
}

- (void)webViewDidClose:(WKWebView *)webView
{
    [self.arrWebView removeLastObject];
    [webView removeFromSuperview];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    if ([SystemInfo IsNetworkUnAvailable]) {
        [self showNetworkError];
    }
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *scheme = navigationAction.request.URL.scheme.lowercaseString;
    NSURL *url = navigationAction.request.URL;

    NSLog(@"url is %@", url);

    if ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"] || [scheme isEqualToString:@"about"]) {
        //scheme이 http, https, about인 경우는 그냥 실행
        decisionHandler(WKNavigationActionPolicyAllow);
        return ;
    }
    else if ([scheme isEqualToString:@"mailto"] ||
             [scheme isEqualToString:@"tel"] ||
             [scheme isEqualToString:@"itms-apps"] ||
             [scheme isEqualToString:@"itms-appss"] ||
             [scheme isEqualToString:@"itmss-apps"]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    // AppStore 연결을 위한 URL인 경우
    else if ([[url absoluteString] rangeOfString:@"itunes.apple.com"].location != NSNotFound) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
        
        return ;
    }
    else if ([scheme isEqualToString:self.appSchemeName]) {
        [self appschemeProcess:url];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    else {
        [[UIApplication sharedApplication] openURL:url
                                           options:@{}
                                 completionHandler:^(BOOL success) {
            decisionHandler(WKNavigationActionPolicyCancel);
            return ;
        }];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    //Cookie 동기화...
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
    
    for (NSHTTPCookie *cookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    isFinished = YES;
    NSLog(@"didFinishNavigation...");
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"didCommitNavigation...");
}
    
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"error is %@", error);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if (error.code == -1001) { //Network Time Out
        
    }
    else if (error.code == -1003) { //Server Cannot be Found
        [self showNetworkError];
        
    }
    else if (error.code == -1100) { //403 Not Found
        
    }
}

#pragma mark - Public Method

- (void)callJavaScript:(NSString *)aScript
{
    [self.wkWeb evaluateJavaScript:aScript
                 completionHandler:^(id value, NSError *error) {
        
    }];
}

- (void)loadRequest:(NSURLRequest *)request
{
    NSMutableURLRequest *req = [request mutableCopy];
    req.timeoutInterval = 3.f;
    [self.wkWeb loadRequest:req];
}

- (void)loadWebURL:(NSString *)aUrl
{
    NSMutableURLRequest *reqeust = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:aUrl]];
    reqeust.timeoutInterval = 60.f;
    //[NSURLRequest requestWithURL:[NSURL URLWithString:aUrl]];
    [self.wkWeb loadRequest:reqeust];
}

- (void)setCookieNew:(NSHTTPCookie *)dictCookie
{
    if (isFinished) {
        [self.wkWeb.configuration.websiteDataStore.httpCookieStore setCookie:dictCookie completionHandler:^{
            [self.wkWeb reload];
        }];
    }
    else {
        NSLog(@"setCookie...");
        [self performSelector:@selector(setCookieNew:) withObject:dictCookie afterDelay:0.2];
    }
}

#pragma mark - init

- (void)setup
{
    WKPreferences *thisPref = [[WKPreferences alloc] init];
    thisPref.javaScriptCanOpenWindowsAutomatically = YES;
    thisPref.javaScriptEnabled = YES;
    
//    NSString *jScript = @"var meta = document.createElement('meta'); meta.name = 'viewport'; meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'; var head = document.getElementsByTagName('head')[0]; head.appendChild(meta);";
//
//    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
//
//    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//    [wkUController addUserScript:wkUScript];
    
    WKWebViewConfiguration *configuration = WKWebViewConfiguration.new;
    configuration.processPool = [WKWebViewPoolHandler pool];
    configuration.allowsInlineMediaPlayback = YES;
    configuration.mediaTypesRequiringUserActionForPlayback = NO;
    configuration.allowsPictureInPictureMediaPlayback = YES;
    configuration.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
    configuration.preferences = thisPref;
    //configuration.userContentController = wkUController;
    configuration.applicationNameForUserAgent = [SDKInfo sharedInstance].userAgent;
    
    self.wkWeb = [[WKWebView alloc] initWithFrame:self.bounds configuration:configuration];
    self.wkWeb.UIDelegate = self;
    self.wkWeb.navigationDelegate = self;
    self.wkWeb.multipleTouchEnabled = NO;
    self.wkWeb.allowsBackForwardNavigationGestures = YES;
    
    [self addSubview:_wkWeb];
    
    self.arrWebView = [NSMutableArray array];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }

    isFinished = NO;
    
    return self;
}


@end

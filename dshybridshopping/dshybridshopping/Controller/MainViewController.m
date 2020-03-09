//
//  MainViewController.m
//  DSHybridSDK
//
//  Created by Sanghong Han on 2019/11/17.
//  Copyright © 2019 directionsoft. All rights reserved.
//

#import "MainViewController.h"
#import "dshybridshopping.h"
#import "DSHybridAppDelegate.h"

//#import "SettingViewController.h"
//#import "AlarmViewController.h"

@interface MainViewController () <DSHybridWebViewDelegate>

@property (nonatomic, strong) NSString *startURL;

@end

@implementation MainViewController

#pragma mark - DSHybridWebView Delegate

- (void)showToastMessage:(NSDictionary *)dict
{
    
}

- (void)openSettingView
{
//    NSBundle *bundle = [NSBundle mainBundle];
//    
//    SettingViewController *controller = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:bundle];
//    controller.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    controller.didDismiss = ^(NSString *closeString) {
//        if ([closeString isEqualToString:@"Logout"]) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.webView callJavaScript:@"overpass.link('LOGOUT');"];
//            });
//        }
//    };
//    [self presentViewController:controller animated:YES completion:^ {}];
}

- (void)showAlarmList
{
//    NSBundle *bundle = [NSBundle mainBundle];
//
//    AlarmViewController *controller = [[AlarmViewController alloc] initWithNibName:@"AlarmViewController" bundle:bundle];
//    controller.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    controller.didDismiss = ^(NSString *closeString) {
//        if ([closeString isEqualToString:@"Logout"]) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.webView callJavaScript:@"overpass.link('LOGOUT');"];
//            });
//        }
//    };
//    [self presentViewController:controller animated:YES completion:^ {}];
}

- (void)phonecall:(NSDictionary *)dict
{
    
}

- (void)sendEmail:(NSDictionary *)dict
{
    
}

- (void)doLogout
{
    
}

- (void)loadUrl:(NSString *)aUrl
{
    [self.webView loadWebURL:aUrl];
}

- (void)callJavaScript:(NSString *)aScript
{
    [self.webView callJavaScript:aScript];
}

#pragma mark - init

- (double)safeBottomY
{
    if (@available(iOS 11.0, *)) {
        if (UIApplication.sharedApplication.windows && (UIApplication.sharedApplication.windows.count > 0)) {
            return UIApplication.sharedApplication.windows[0].safeAreaInsets.bottom;
        }
        else return 0;
    } else {
        return 0;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    DSHybridAppDelegate *app = (DSHybridAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (app.pushUrl && ([app.pushUrl isEqualToString:@""] == NO)) {
        [self loadUrl:app.pushUrl];
        app.pushUrl = @"";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.startURL = [SDKInfo sharedInstance].startPage;
    
    CGFloat xPos = 0;
    CGFloat yPos = StartY;
    CGFloat nHeight = kScreenBoundsHeight - yPos - [self safeBottomY];
    
    self.webView = [[DSHybridWebView alloc] initWithFrame:CGRectMake(xPos, yPos, kScreenBoundsWidth, nHeight)];
    self.webView.delegate = self;
    self.webView.appSchemeName = @"galleriaapp";
    [self.view addSubview:self.webView];
    
    [self.webView loadWebURL:self.startURL];
}


@end

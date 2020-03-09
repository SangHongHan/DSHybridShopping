//
//  MainViewController.h
//  DSHybridSDK
//
//  Created by Sanghong Han on 2019/11/17.
//  Copyright © 2019 directionsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHybridWebView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController

@property (nonatomic, strong) DSHybridWebView *webView;

- (void)loadUrl:(NSString *)aUrl;
- (void)callJavaScript:(NSString *)aScript;

@end

NS_ASSUME_NONNULL_END

//
//  ToastView.h
//  DSHybridSDK
//
//  Created by HanSanghong on 2016. 8. 9..
//  Copyright © 2019년 Directionsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToastView : UIView

@property (nonatomic, strong) NSString  *toastMsg;

- (void)showToastWithTime:(float)nDuration;
- (void)showToast;

@end

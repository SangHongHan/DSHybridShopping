//
//  NoticePopupView.h
//  Galleria
//
//  Copyright © 2019 pionnet. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol NoticePopupDelegate <NSObject>

- (void)didTouchCloseBtn:(id)sender;
@end

@interface NoticePopupView : UIView

- (void)descStr:(NSString *)strDesc type:(int)type;
- (void)showPopup;
@property (nonatomic, assign) id<NoticePopupDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

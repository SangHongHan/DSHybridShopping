//
//  AccessPopupView.h
//  Galleria
//
//  Copyright © 2019 pionnet. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AccessPopupDelegate <NSObject>
- (void)didTouchMenuBtn:(id)sender type:(int)type;
@optional
- (void)didTouchCloseButton:(int)type;
@end

@interface AccessPopupView : UIView

- (void)descStr:(int)type;
- (void)showPopup;

@property (nonatomic, assign) id<AccessPopupDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

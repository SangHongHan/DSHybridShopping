//
//  IntroView.h
//  elandmall
//
//  Created by kbj on 2016. 2. 05..
//  Copyright © 2016년 pionnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroViewDelegate <NSObject>

@optional
- (void)didIntroCompleted;
@end

@interface IntroView : UIView

@property (nonatomic, assign) id<IntroViewDelegate> delegate;

- (void)showIntro;
- (void)hideIntro;

@end

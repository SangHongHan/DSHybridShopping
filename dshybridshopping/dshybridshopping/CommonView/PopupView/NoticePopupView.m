//
//  NoticePopupView.m
//  Galleria
//
//  Copyright © 2019 pionnet. All rights reserved.
//

#import "NoticePopupView.h"

@interface NoticePopupView()
{
    IBOutlet UILabel *lbDesc;
    IBOutlet UILabel *lbDesc2;
}

@property (weak, nonatomic) IBOutlet UIView *dimmedView;
@end

@implementation NoticePopupView

#pragma mark - Touch Event

- (IBAction)didTouchClosePopoup:(id)sender
{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didTouchCloseBtn:)]) {
        [_delegate didTouchCloseBtn:sender];
    }
    [self removeFromSuperview];
}

#pragma mark - init
- (void)descStr:(NSString *)strDesc type:(int)type{
    
    NSString *strDate = @"";//[GMCommon todayStringWithFormat:@"yyyy년 MM월 dd일 hh시 mm분 si초"];    
    NSString *str = [NSString stringWithFormat:@"%@\n%@",strDate, strDesc];
    
    lbDesc.text = str;
    if(type == 0){
        lbDesc2.text = @"* 알림설정 변경 > 앱설정 > 구매 알림 받기";
    }else {
        lbDesc2.text = @"* 알림설정 변경 > 앱설정 > 쇼핑 알림 받기";
    }
}

- (void)showPopup{
    [UIView animateWithDuration:0.3/1.5 animations:^{
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                self.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

//- (void)removeFromSuperview{
//    [UIView animateWithDuration:0.3/1.5 animations:^{
//        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
//    } completion:^(BOOL finished) {
//        if ([super respondsToSelector:@selector(removeFromSuperview)]) {
//            [super removeFromSuperview];
//        }
//    }];
//}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
}

@end

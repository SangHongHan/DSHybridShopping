//
//  AccessPopupView.m
//  Galleria
//
//  Copyright © 2019 pionnet. All rights reserved.
//

#import "AccessPopupView.h"

@interface AccessPopupView()
{
    IBOutlet UILabel *lbTitle;
    IBOutlet UILabel *lbDesc;
    IBOutlet UIButton *btnCancel;
    IBOutlet UIButton *btnOk;
    int descType;
}


@property (weak, nonatomic) IBOutlet UIView *dimmedView;
@end

@implementation AccessPopupView

#pragma mark - IBAction Method

- (IBAction)didTouchCloseBtn:(id)sender{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didTouchCloseButton:)]) {
        [self.delegate didTouchCloseButton:descType];
    }
    [self removeFromSuperview];
}

- (IBAction)didTouchMenuBtn:(id)sender
{
    [self.delegate didTouchMenuBtn:sender type:descType];
    [self removeFromSuperview];
}
- (void)descStr:(int)type{
    descType = type;
    switch (type) {
        case 0:
            lbTitle.text = @"갤러리아몰이 사용자의 사진/\n카메라에 접근하려고 합니다.";
            lbDesc.text = @"(사용 목적:포토/동영상 상품평)";
            [btnCancel setTitle:@"허용 안함" forState:UIControlStateNormal];
            [btnOk setTitle:@"허용" forState:UIControlStateNormal];
            break;
        case 1:
            lbTitle.text = @"개러리아몰이 마이크에\n 접근하려고 합니다.";
            lbDesc.text = @"(사용 목적:음성검색)";
            [btnCancel setTitle:@"허용 안함" forState:UIControlStateNormal];
            [btnOk setTitle:@"허용" forState:UIControlStateNormal];
            break;
        case 2:
            lbTitle.text = @"갤러리아몰";
            lbDesc.text = @"이동통신망(3G/4G LTE)를 이용하여 동영상을\n재생하면 별도의 데이터 통화료가 부과될 수 있\n습니다.";
            [btnCancel setTitle:@"취소" forState:UIControlStateNormal];
            [btnOk setTitle:@"재생" forState:UIControlStateNormal];
            break;
        case 3:
            lbTitle.text = @"알림 수신 여부 안내";
            lbDesc.text = @"구매 정보 알림 받기를 OFF 하시면 쇼핑/혜택\n방기 알림도 자동으로 해제 됩니다.";
            [btnCancel setTitle:@"아니요" forState:UIControlStateNormal];
            [btnOk setTitle:@"예" forState:UIControlStateNormal];
            break;
        case 4:
            lbTitle.text = @"알림 수신 여부 안내";
            lbDesc.text = @"쇼핑/혜택 알림 받기를 원하시는 경우 구매 정\n보 알림 받기가 먼저 ON 되어 있어야 합니다.";
            [btnCancel setTitle:@"아니요" forState:UIControlStateNormal];
            [btnOk setTitle:@"예" forState:UIControlStateNormal];
            break;
        case 5:
            lbTitle.text = @"임시 저장된 캐시 데이타를\n 삭제 하시겠습니까?";
            lbDesc.text = @"";
            lbDesc.frame = CGRectZero;
            [btnCancel setTitle:@"아니요" forState:UIControlStateNormal];
            [btnOk setTitle:@"예" forState:UIControlStateNormal];
            break;
        default:
            break;
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

#pragma mark - init

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
}

@end

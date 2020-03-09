//
//  IntroView.m
//  elandmall
//
//  Created by kbj on 2016. 2. 11..
//  Copyright © 2016년 pionnet. All rights reserved.
//

#import "IntroView.h"
#import "dshybridshopping.h"

#import "CommonAlertView.h"
#import "DSHybridAppDelegate.h"

#import <PINRemoteImage/PINRemoteImage.h>
#import <PINRemoteImage/PINImageView+PINRemoteImage.h>

#import "NetworkManager.h"

#define IntroImageCount 1

@interface IntroView()
{

}

@property (weak, nonatomic) IBOutlet UIImageView *imgBack;
@property (nonatomic, assign) BOOL isIntroCompleted;
@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;

@end

@implementation IntroView

#pragma mark - Public Method

- (void)introComplete
{
    NSLog(@"showIntro end....");
    if (self.isIntroCompleted) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.delegate didIntroCompleted];
        });
    }
    else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.delegate didIntroCompleted];
        });
    }
}

// 인트로 화면 보여주기
- (void)showIntro
{
    if ([SDKInfo sharedInstance].showIntro) {
        [self requestIntro];
    }
    else {
        [self requestVersionCheck];
    }
}

// 인트로 화면 감추기
- (void)hideIntro
{
    [self introComplete];
}

- (void)showNormalUpdate
{
    CommonAlertView *alert = [[CommonAlertView alloc] init];
    [alert showCustomAlertView:nil
                         title:@""
                       message:@"새 버전의 갤러이아몰이 있습니다.\n지금 업데이트하시겠습니까?"
             cancelButtonTitle:@"나중에"
                 okButtonTitle:@"업데이트"];
    alert.okClick = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURL *url = [NSURL URLWithString:[SettingInfo sharedInstance].sAppStoreURL];
            [[UIApplication sharedApplication] openURL:url
                                               options:@{}
                                     completionHandler:^(BOOL success) {
            }];
        });
    };
    alert.cancelClick = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self introComplete];
        });
    };
}

- (void)showForceUpdate
{
    CommonAlertView *alert = [[CommonAlertView alloc] init];
    [alert showCustomAlertView:nil
                         title:@""
                       message:@"갤러리아몰 APP이 업데이트되었습니다.\n최신버전으로 업데이트후 이용해주시기 바랍니다."
             cancelButtonTitle:@"종료"
                 okButtonTitle:@"업데이트"];
    alert.okClick = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURL *url = [NSURL URLWithString:[SettingInfo sharedInstance].sAppStoreURL];
            [[UIApplication sharedApplication] openURL:url
                                               options:@{}
                                     completionHandler:^(BOOL success) {
            }];
        });
    };
    alert.cancelClick = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [(DSHybridAppDelegate *)[[UIApplication sharedApplication] delegate] AppExit];
        });
    };
}

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

#pragma mark - init

- (void)initData
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initData];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    
    return self;
}

#pragma mark - Call API Function

- (void)requestIntro
{
    NSString *sUrl = [NSString stringWithFormat:@"%@%@", [SDKInfo sharedInstance].apiUrl, API_INTRO];
    self.isIntroCompleted = NO;
    
    NSMutableDictionary *dictParam = [NSMutableDictionary dictionary];
    [dictParam setValue:[SDKInfo sharedInstance].siteNo forKey:@"site_no"];
    [dictParam setValue:@"20" forKey:@"appCd"];
    
    [NetworkManager sendRequest:sUrl
                     parameters:dictParam
                        success:^(NSDictionary *response) {
        NSLog(@"requestIntro result is %@", response);
        self.imgLogo.hidden = YES;
        [self requestVersionCheck];
        
        NSArray *arrTemp = response[@"splashImg"];
        if (arrTemp && (arrTemp.count > 0)) {
            NSDictionary *dictIntroImage = arrTemp[0];
            if (dictIntroImage && dictIntroImage[@"imageUrl"]) {
                NSString *sImgUrl = dictIntroImage[@"imageUrl"];
                NSLog(@"sImgUrl is %@", sImgUrl);
                
                [self.imgBack pin_setImageFromURL:[NSURL URLWithString:sImgUrl] completion:^(PINRemoteImageManagerResult *result) {
                    self.isIntroCompleted = YES;
                }];
            }
            else {
                self.isIntroCompleted = YES;
            }
        }
        else {
            self.isIntroCompleted = YES;
        }
    } failure:^(NSError *error) {
        NSLog(@"requestIntro error is %@", error);
        self.imgLogo.hidden = YES;
        [self requestVersionCheck];
    }];
}

- (void)requestVersionCheck
{
    NSMutableDictionary *dictParams = [NSMutableDictionary dictionary];
    [dictParams setValue:APPVERSION forKey:@"version"];
    [dictParams setValue:[SDKInfo sharedInstance].siteNo forKey:@"site_no"];
    [dictParams setValue:@"20" forKey:@"appCd"];
    
    NSString *sUrl = [NSString stringWithFormat:@"%@%@", [SDKInfo sharedInstance].apiUrl, API_VERSIONCHECK];

    [NetworkManager sendRequest:sUrl
                     parameters:dictParams
                        success:^(NSDictionary *response) {
        self.imgLogo.hidden = YES;
        NSLog(@"requestVersionCheck result is %@", response);
        
        NSDictionary *dictInfo = response[@"app"];
        if (dictInfo && [dictInfo isKindOfClass:[NSDictionary class]]) {
            NSString *updateType = dictInfo[@"appUpdateType"];
            if ([[updateType uppercaseString] isEqualToString:@"A"]) {
                //No Udpate
                [SettingInfo sharedInstance].isNeedUpdate = NO;
                [SettingInfo sharedInstance].sServerVersion = APPVERSION;
                [SettingInfo sharedInstance].sAppStoreURL = dictInfo[@"path"];
                [self introComplete];
            }
            else if ([[updateType uppercaseString] isEqualToString:@"B"]) {
                //Normal Update
                [SettingInfo sharedInstance].isNeedUpdate = YES;
                [SettingInfo sharedInstance].sServerVersion = dictInfo[@"appNewVersion"];
                [SettingInfo sharedInstance].sAppStoreURL = dictInfo[@"path"];
                [self showNormalUpdate];
            }
            if ([[updateType uppercaseString] isEqualToString:@"C"]) {
                //Force Update
                [SettingInfo sharedInstance].isNeedUpdate = YES;
                [self showForceUpdate];
            }
        }
        else {
            [SettingInfo sharedInstance].isNeedUpdate = NO;
            [self introComplete];
        }
    } failure:^(NSError *error) {
        NSLog(@"requestVersionCheck error is %@", error);
        //[self showNetworkError];
        [self introComplete];
    }];
}

@end

//
//  SystemInfo.m
//  DSHybridSDK
//
//  Created by HanSanghong on 2016. 8. 2..
//  Copyright © 2019년 Directionsoft. All rights reserved.
//

#import "SystemInfo.h"
#import "Reachability.h"
#import <sys/utsname.h>
#import <sys/sysctl.h>

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <UIKit/UIDevice.h>

@implementation SystemInfo

+ (NSString *)getDeviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (NSString *)platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+ (NSString*)getCurrierName
{
    NSString* str = @"";
    
    // Setup the Network Info and create a CTCarrier object
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = nil;
    
    if (@available(iOS 12.1, *)) {
        NSArray *arrService = [[networkInfo serviceSubscriberCellularProviders] allValues];
        if (arrService && (arrService.count > 0)) {
            carrier = arrService[0];
        }
    }
    else {
        carrier = [networkInfo subscriberCellularProvider];
    }
    
    if (carrier) {
        str = [carrier carrierName];
    }
    
    if (str != nil)
        NSLog(@"Carrier: %@", str);

    return str;
}

+ (NSString *)getDeviceOS
{
    return @"iOS";
}

+ (NSString *)getOSVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)getOrientation
{
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) ||
        ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        return @"Landscape";
        
    } else {
        return @"Portrait";
    }
}

+ (BOOL)IsNetworkUnAvailable {
    NetworkStatus netStatus =  [[Reachability reachabilityForInternetConnection]currentReachabilityStatus];
    return (netStatus==NotReachable);
}

@end

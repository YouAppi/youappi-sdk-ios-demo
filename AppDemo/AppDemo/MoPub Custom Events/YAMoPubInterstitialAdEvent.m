//
//  YAInterstitialEvent.m
//  MoPubTest
//
//  Created by Action Item on 08/02/2017.
//  Copyright © 2017 Action Item. All rights reserved.
//

#import "YAMoPubInterstitialAdEvent.h"
@import YouAppi;

#warning Don't forget to fill the access token for YouAppi
#define YOUAPPI_ACCESS_TOKEN @"c519c1e2-3c59-4960-aa17-ec03df294767"

@implementation YAMoPubInterstitialAdEvent
{
    YAAdCard *interstitialAd;
}
- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    [YouAppi initializeWithAccessToken:YOUAPPI_ACCESS_TOKEN];
    interstitialAd = [[YouAppi sharedInstance] interstitialAd:@"interstitialAdUnitID"];
    interstitialAd.delegate = self;
    [interstitialAd load];
    
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    [self showAd];
}

- (void)showAd
{
    if (!interstitialAd.isAvailable) return;

    [interstitialAd show];
}

#pragma mark - YAAdDelegate Delegates

- (void)onLoadSuccessWithAdUnitID:(NSString * _Nonnull)adUnitID;
{
    [self.delegate interstitialCustomEvent:self didLoadAd:nil];
}

- (void)onLoadFailureWithAdUnitID:(NSString * _Nonnull)adUnitID errorCode:(enum YAErrorCode)errorCode error:(NSError * _Nullable)error
{
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)onAdStartedWithAdUnitID:(NSString * _Nonnull)adUnitID
{
    [self.delegate interstitialCustomEventWillAppear:self];
    [self.delegate interstitialCustomEventDidAppear:self];
}

- (void)onAdEndedWithAdUnitID:(NSString * _Nonnull)adUnitID
{
    [self.delegate interstitialCustomEventWillLeaveApplication:self];
    [self.delegate interstitialCustomEventWillDisappear:self];
    [self.delegate interstitialCustomEventDidDisappear:self];    
}



@end

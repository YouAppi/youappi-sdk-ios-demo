//
//  YAAdMobIntertitialAdEvent.m
//  YAAdMobIntertitialAdEvent
//
//  Created by Action Item on 12/02/2017.
//  Copyright © 2017 Action Item. All rights reserved.
//

#import "YAAdMobIntertitialAdEvent.h"

#warning Don't forget to fill the access token for YouAppi
#define YOUAPPI_ACCESS_TOKEN @""

@implementation YAAdMobIntertitialAdEvent
{
    id<GADCustomEventInterstitialDelegate> _delegate;
}

- (void)requestInterstitialAdWithParameter:(NSString *)serverParameter label:(NSString *)serverLabel request:(GADCustomEventRequest *)request
{
    [[YouAppi sharedInstance] initializeWithAccessToken:YOUAPPI_ACCESS_TOKEN];
    [[YouAppi sharedInstance] cardAd].delegate = self;
}

- (void)setDelegate:(id<GADCustomEventInterstitialDelegate>)delegate
{
    _delegate = delegate;
}

- (id<GADCustomEventInterstitialDelegate>)delegate
{
    return _delegate;
}

- (void)presentFromRootViewController:(UIViewController *)rootViewController
{
    [self showAd];
}

- (void)showAd
{
    YAAdCard *interstitialAd = [[YouAppi sharedInstance] cardAd];
    if (!interstitialAd.isAvailable) return;
    
    [interstitialAd show];
}

#pragma mark - YAAdDelegates

- (void)adWillLeaveApplicationWithYouAppi:(YouAppi *)youAppi
                                   adType:(AdType)adType
{
    [self.delegate customEventInterstitialWillLeaveApplication:self];
}

- (void)adDidCloseWithYouAppi:(YouAppi *)youAppi
                       adType:(AdType)adType
{
    [self.delegate customEventInterstitialWillDismiss:self];
    [self.delegate customEventInterstitialDidDismiss:self];
}

- (void)adDidShownWithYouAppi:(YouAppi *)youAppi
                       adType:(AdType)adType
{
    [self.delegate customEventInterstitialWillPresent:self];
}

- (void)adDidClickedWithYouAppi:(YouAppi *)youAppi
                         adType:(AdType)adType
{
    [self.delegate customEventInterstitialWasClicked:self];
}

- (void)adDidInitializeWithYouAppi:(YouAppi *)youAppi
                            adType:(AdType)adType
{
    [self.delegate customEventInterstitialDidReceiveAd:self];
}

- (void)adPreloadFailedWithYouAppi:(YouAppi *)youAppi
                            adType:(AdType)adType
                             error:(NSError *)error
{
    [self.delegate customEventInterstitial:self didFailAd:error];
}

- (void)adRetrievalFailedWithYouAppi:(YouAppi *)youAppi
                              adType:(AdType)adType
                               error:(NSError *)error
{
    [self.delegate customEventInterstitial:self didFailAd:error];
}

@end

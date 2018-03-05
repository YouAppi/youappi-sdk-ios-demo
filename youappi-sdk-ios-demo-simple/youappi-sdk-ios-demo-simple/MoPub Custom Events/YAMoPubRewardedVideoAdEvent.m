//
//  YAMoPubRewardedVideoAdEvent.m
//  YAMoPubRewardedVideoAdEvent
//
//  Created by Action Item on 08/02/2017.
//  Copyright © 2017 Action Item. All rights reserved.
//

#import "YAMoPubRewardedVideoAdEvent.h"
#import "MPRewardedVideoReward.h"

#warning Don't forget to fill the access token for YouAppi
#define YOUAPPI_ACCESS_TOKEN @"c519c1e2-3c59-4960-aa17-ec03df294767"

@implementation YAMoPubRewardedVideoAdEvent
{
    YAAdRewardedVideo *rewardedVideo;
}
- (void)requestRewardedVideoWithCustomEventInfo:(NSDictionary *)info
{
    [YouAppi initializeWithAccessToken:YOUAPPI_ACCESS_TOKEN];
    rewardedVideo = [[YouAppi sharedInstance] rewardedVideo:@"rewardedVideoAdUnitID"];
    rewardedVideo.delegate = self;
    [rewardedVideo load];
}

- (void)presentRewardedVideoFromViewController:(UIViewController *)viewController
{
    [self showAd];
}

- (void)showAd
{
    if (!rewardedVideo.isAvailable) return;
    
    [rewardedVideo show];
}

#pragma mark - YAAdDelegate Delegates

- (void)onLoadSuccessWithAdUnitID:(NSString * _Nonnull)adUnitID;
{
    [self.delegate rewardedVideoDidLoadAdForCustomEvent:self];
}

- (void)onLoadFailureWithAdUnitID:(NSString * _Nonnull)adUnitID errorCode:(enum YAErrorCode)errorCode error:(NSError * _Nullable)error
{
    [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:error];
   
}

- (void)onShowFailureWithAdUnitID:(NSString * _Nonnull)adUnitID errorCode:(enum YAErrorCode)errorCode error:(NSError * _Nullable)error{
     [self.delegate rewardedVideoDidFailToPlayForCustomEvent:self error:error];
}

- (void)onAdStartedWithAdUnitID:(NSString * _Nonnull)adUnitID
{
    [self.delegate rewardedVideoWillAppearForCustomEvent:self];
    [self.delegate rewardedVideoDidAppearForCustomEvent:self];
}

- (void)onAdEndedWithAdUnitID:(NSString * _Nonnull)adUnitID
{
    [self.delegate rewardedVideoWillDisappearForCustomEvent:self];
    [self.delegate rewardedVideoDidDisappearForCustomEvent:self];
}

- (void)onRewardedWithAdUnitID:(NSString * _Nonnull)adUnitID;
{
    MPRewardedVideoReward *reward = [[MPRewardedVideoReward alloc] initWithCurrencyAmount:@(5)];
    [self.delegate rewardedVideoShouldRewardUserForCustomEvent:self reward:reward];
}



@end

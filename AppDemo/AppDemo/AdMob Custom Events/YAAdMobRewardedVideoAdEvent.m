//
//  YAAdMobRewardedVideoAdEvent.m
//  YAAdMobRewardedVideoAdEvent
//
//  Created by Action Item on 12/02/2017.
//  Copyright © 2017 Action Item. All rights reserved.
//

#import "YAAdMobRewardedVideoAdEvent.h"

#warning Don't forget to fill the access token for YouAppi
#define YOUAPPI_ACCESS_TOKEN @""

@implementation YAAdMobRewardedVideoAdEvent
{
    id<GADMRewardBasedVideoAdNetworkConnector> _rewardBasedVideoAdConnector;
}

- (instancetype)initWithRewardBasedVideoAdNetworkConnector:(id<GADMRewardBasedVideoAdNetworkConnector>)connector
{
    if (!connector)
    {
        return nil;
    }
        
    self = [super init];
    if (self)
    {
        _rewardBasedVideoAdConnector = connector;
    }
    return self;
}

- (void)setUp
{
    [[YouAppi sharedInstance] initializeWithAccessToken:YOUAPPI_ACCESS_TOKEN];
    [[YouAppi sharedInstance] rewardedVideo].delegate = self;
}

- (void)requestRewardBasedVideoAd
{
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardBasedVideoAdConnector;
    if ([[YouAppi sharedInstance] rewardedVideo].isAvailable)
    {
        [strongConnector adapterDidReceiveRewardBasedVideoAd:self];
    }
    else
    {
        NSString *description = @"Failed to load ad.";
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey : description,
                                   NSLocalizedFailureReasonErrorKey : description
                                   };
        NSError *error = [NSError errorWithDomain:@"com.google.mediation.youappi" code:0 userInfo:userInfo];
        [strongConnector adapter:self didFailToLoadRewardBasedVideoAdwithError:error];
    }
}

- (void)presentRewardBasedVideoAdWithRootViewController:(UIViewController *)viewController
{
    [self showAd];
}

- (void)presentFromRootViewController:(UIViewController *)rootViewController
{
    [self showAd];
}

- (void)showAd
{
    YAAdRewardedVideo *video = [[YouAppi sharedInstance] rewardedVideo];
    if (!video.isAvailable)
    {
        NSLog(@"No ads to show.");
        return;
    }
    
    [video show];
}

#pragma mark - YAAdDelegates

- (void)adWillLeaveApplicationWithYouAppi:(YouAppi *)youAppi
                                   adType:(AdType)adType
{
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardBasedVideoAdConnector;
    [strongConnector adapterWillLeaveApplication:nil];
}

- (void)adDidCloseWithYouAppi:(YouAppi *)youAppi
                       adType:(AdType)adType
{
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardBasedVideoAdConnector;
    [strongConnector adapterDidCloseRewardBasedVideoAd:nil];
}

- (void)adDidShownWithYouAppi:(YouAppi *)youAppi
                       adType:(AdType)adType
{
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardBasedVideoAdConnector;
    [strongConnector adapterDidOpenRewardBasedVideoAd:nil];
    [strongConnector adapterDidStartPlayingRewardBasedVideoAd:nil];
}

- (void)adDidInitializeWithYouAppi:(YouAppi *)youAppi
                            adType:(AdType)adType
{
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardBasedVideoAdConnector;
    [strongConnector adapterDidSetUpRewardBasedVideoAd:nil];
}

- (void)adPreloadFailedWithYouAppi:(YouAppi *)youAppi
                            adType:(AdType)adType
                             error:(NSError *)error
{
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardBasedVideoAdConnector;
    [strongConnector adapter:nil didFailToLoadRewardBasedVideoAdwithError:error];
}

- (void)adDidRewardedWithYouAppi:(YouAppi *)youAppi adType:(enum AdType)adType
{
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardBasedVideoAdConnector;
    GADAdReward *rewardItem =
    [[GADAdReward alloc] initWithRewardType:@""
                               rewardAmount:[NSDecimalNumber numberWithInteger:10]];
    [strongConnector adapter:nil didRewardUserWithReward:rewardItem];
}

@end

//
//  YAAdMobRewardedVideoAdEvent.h
//  YAAdMobRewardedVideoAdEvent
//
//  Created by Action Item on 12/02/2017.
//  Copyright © 2017 Action Item. All rights reserved.
//

#import <GoogleMobileAds/GADCustomEventInterstitial.h>
#import <GoogleMobileAds/GADCustomEventInterstitialDelegate.h>
#import <GoogleMobileAds/GADRewardBasedVideoAd.h>

@import YouAppi;
#import "YAAd.h"
@interface YAAdMobRewardedVideoAdEvent : NSObject <YAAdDelegate, GADMRewardBasedVideoAdNetworkAdapter>

@end

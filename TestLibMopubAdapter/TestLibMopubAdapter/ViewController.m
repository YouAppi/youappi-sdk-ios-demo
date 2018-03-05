//
//  ViewController.m
//  TestLibMopubAdapter
//
//  Created by Itamar Menahem on 2/25/18.
//  Copyright © 2018 Itamar Menahem. All rights reserved.
//

#import "ViewController.h"

#define RewardedUnitID @"fb26490cb5cd450dae218ed683bae687"
#define InterstitialVideoUnitID @"29e889ae3315428087ef9b4bd72a5291"
#define InterstitialADUnitID @"3eb931acaa33483ebccab1505c0de78f"

@interface ViewController ()

@end

@implementation ViewController
{
    MPRewardedVideo *rewardedVideo;
    MPInterstitialAdController *interstitialVideo;
    MPInterstitialAdController *interstitialAd;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadRewardedVideo {
    
    // Initialize rewarded video before loading any ads.
    [[MoPub sharedInstance] initializeRewardedVideoWithGlobalMediationSettings:nil delegate:self];
    
    // Fetch the rewarded video ad.
    [MPRewardedVideo loadRewardedVideoAdWithAdUnitID:RewardedUnitID withMediationSettings:nil];
}

- (void)loadInterstitialVideo {
    
    // Initialize interstitial video before loading any ads.
    interstitialVideo = [MPInterstitialAdController interstitialAdControllerForAdUnitId:InterstitialVideoUnitID];
    interstitialVideo.delegate = self;
    [interstitialVideo loadAd];
}

- (void)loadInterstitialAd {
    
    // Initialize interstitial video before loading any ads.
    interstitialAd = [MPInterstitialAdController interstitialAdControllerForAdUnitId:InterstitialADUnitID];
    interstitialAd.delegate = self;
    [interstitialAd loadAd];
}
- (IBAction)btnLoad:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            [self loadRewardedVideo];
            break;
        case 2:
            [self loadInterstitialVideo];
            break;
        case 3:
            [self loadInterstitialAd];
            break;
        default:
            break;
    }
}

- (IBAction)btnShow:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            if ([MPRewardedVideo hasAdAvailableForAdUnitID:RewardedUnitID]){
                [MPRewardedVideo presentRewardedVideoAdForAdUnitID:RewardedUnitID fromViewController:self];
            }
            break;
        case 2:
            if (interstitialVideo.ready){
                [interstitialVideo showFromViewController:self];
            }
            break;
        case 3:
            if (interstitialAd.ready){
                [interstitialAd showFromViewController:self];
            }
            break;
        default:
            break;
    }
}

#pragma Mark - MPInterstitialCustomEvent Delegate
- (void)interstitialCustomEvent:(MPInterstitialCustomEvent *)customEvent
                      didLoadAd:(id)ad{
    NSLog(@"interstitialCustomEvent didLoadAd");
}
- (void)interstitialCustomEvent:(MPInterstitialCustomEvent *)customEvent
       didFailToLoadAdWithError:(NSError *)error{
    NSLog(@"interstitialCustomEvent didFailToLoadAdWithError");
}
- (void)interstitialCustomEventDidExpire:(MPInterstitialCustomEvent *)customEvent{
    NSLog(@"interstitialCustomEventDidExpire");
}
- (void)interstitialCustomEventWillAppear:(MPInterstitialCustomEvent *)customEvent{
    NSLog(@"interstitialCustomEventWillAppear");
}
- (void)interstitialCustomEventDidAppear:(MPInterstitialCustomEvent *)customEvent{
    NSLog(@"interstitialCustomEventDidAppear");
}
- (void)interstitialCustomEventWillDisappear:(MPInterstitialCustomEvent *)customEvent{
    NSLog(@"interstitialCustomEventWillDisappear");
}
- (void)interstitialCustomEventDidDisappear:(MPInterstitialCustomEvent *)customEvent{
    NSLog(@"interstitialCustomEventDidDisappear");
}
- (void)interstitialCustomEventDidReceiveTapEvent:(MPInterstitialCustomEvent *)customEvent{
    NSLog(@"interstitialCustomEventDidReceiveTapEvent");
}
- (void)interstitialCustomEventWillLeaveApplication:(MPInterstitialCustomEvent *)customEvent{
    NSLog(@"interstitialCustomEventWillLeaveApplication");
}

#pragma Mark - MPRewardedVideo Delegate

- (void)rewardedVideoAdDidLoadForAdUnitID:(NSString *)adUnitID{
    NSLog(@"rewardedVideoAdDidLoadForAdUnitID %@",adUnitID);
}
- (void)rewardedVideoAdDidFailToLoadForAdUnitID:(NSString *)adUnitID error:(NSError *)error{
    NSLog(@"rewardedVideoAdDidFailToLoadForAdUnitID %@",adUnitID);
}
- (void)rewardedVideoAdWillAppearForAdUnitID:(NSString *)adUnitID{
    NSLog(@"rewardedVideoAdWillAppearForAdUnitID %@",adUnitID);
}
- (void)rewardedVideoAdDidAppearForAdUnitID:(NSString *)adUnitID{
    NSLog(@"rewardedVideoAdDidAppearForAdUnitID %@",adUnitID);
}
- (void)rewardedVideoAdWillDisappearForAdUnitID:(NSString *)adUnitID{
    NSLog(@"rewardedVideoAdWillDisappearForAdUnitID %@",adUnitID);
}
- (void)rewardedVideoAdDidDisappearForAdUnitID:(NSString *)adUnitID{
    NSLog(@"rewardedVideoAdDidDisappearForAdUnitID %@",adUnitID);
}
- (void)rewardedVideoAdDidExpireForAdUnitID:(NSString *)adUnitID{
    NSLog(@"rewardedVideoAdDidExpireForAdUnitID %@",adUnitID);
}
- (void)rewardedVideoAdDidFailToPlayForAdUnitID:(NSString *)adUnitID error:(NSError *)error{
    NSLog(@"rewardedVideoAdDidFailToPlayForAdUnitID %@",adUnitID);
}
- (void)rewardedVideoAdDidReceiveTapEventForAdUnitID:(NSString *)adUnitID{
    NSLog(@"rewardedVideoAdDidReceiveTapEventForAdUnitID %@",adUnitID);
}
- (void)rewardedVideoAdWillLeaveApplicationForAdUnitID:(NSString *)adUnitID{
    NSLog(@"rewardedVideoAdWillLeaveApplicationForAdUnitID %@",adUnitID);
}
- (void)rewardedVideoAdShouldRewardForAdUnitID:(NSString *)adUnitID reward:(MPRewardedVideoReward *)reward{
    NSLog(@"rewardedVideoAdShouldRewardForAdUnitID %@",adUnitID);
}
@end

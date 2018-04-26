//
//  ViewController.m
//  AppDemoAdMob
//
//  Created by Itamar Menahem on 2/14/18.
//  Copyright © 2018 Itamar Menahem. All rights reserved.
//

#import "ViewController.h"

#define AdMobAppID @"ca-app-pub-9942448998483932~7115477466"

#define RewardedUnitIDAdMob @"ca-app-pub-9942448998483932/1723549982"
#define InterstitialVideoUnitIDAdMob @"ca-app-pub-9942448998483932/7949761579"
#define InterstitialADUnitIDAdMob @"ca-app-pub-9942448998483932/9353562336"

#define ADMOB_EXTRAS_PARAMS_KEY @"ADMOB_EXTRAS_PARAMS_KEY"

@interface ViewController ()
@property(nonatomic, strong) GADInterstitial *interstitialVideoAdMob;
@property(nonatomic, strong) GADInterstitial *interstitialAdAdMob;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initAdMob];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initAdMob{
    [GADMobileAds configureWithApplicationID:AdMobAppID];
}

- (void)loadRewardedVideoAdMob {
    
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
    GADRequest *request = [GADRequest request];
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:request
                                           withAdUnitID:RewardedUnitIDAdMob];
}

- (void)loadInterstitialVideoAdMob {
    self.interstitialVideoAdMob = [[GADInterstitial alloc]
                                   initWithAdUnitID:InterstitialVideoUnitIDAdMob];
    self.interstitialVideoAdMob.delegate = self;
    GADRequest *request = [GADRequest request];
    [self.interstitialVideoAdMob loadRequest:request];
}

- (void)loadInterstitialAdAdMob {
    self.interstitialAdAdMob = [[GADInterstitial alloc]
                                initWithAdUnitID:InterstitialADUnitIDAdMob];
    self.interstitialAdAdMob.delegate = self;
    GADRequest *request = [GADRequest request];
    [self.interstitialAdAdMob loadRequest:request];
}

- (IBAction)btnLoad:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            [self loadRewardedVideoAdMob];
            break;
        case 2:
            [self loadInterstitialVideoAdMob];
            break;
        case 3:
            [self loadInterstitialAdAdMob];
            break;
        default:
            break;
    }
}


- (IBAction)btnShow:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
                [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
            }
            break;
        case 2:
            if (self.interstitialVideoAdMob.isReady) {
                [self.interstitialVideoAdMob presentFromRootViewController:self];
            } else {
                NSLog(@"Ad wasn't ready");
            }
            break;
        case 3:
            if (self.interstitialAdAdMob.isReady){
                [self.interstitialAdAdMob presentFromRootViewController:self];
            }else {
                NSLog(@"Ad wasn't ready");
            }
            break;
        default:
            break;
    }
}
#pragma mark - interstitial ad mob Delegate

/// Tells the delegate an ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"interstitialDidReceiveAd");
}

/// Tells the delegate an ad request failed.
- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that an interstitial will be presented.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillPresentScreen");
}

/// Tells the delegate the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillDismissScreen");
}

/// Tells the delegate the interstitial had been animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialDidDismissScreen");
}

/// Tells the delegate that a user click will open another app
/// (such as the App Store), backgrounding the current app.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"interstitialWillLeaveApplication");
}

#pragma mark - admob rewarded delegate

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
    NSString *rewardMessage =
    [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf", reward.type, [reward.amount doubleValue]];
    NSLog(@"%@", rewardMessage);
}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is received.");
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Opened reward based video ad.");
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad started playing.");
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is closed.");
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad will leave application.");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    NSLog(@"Reward based video ad failed to load.");
}

@end

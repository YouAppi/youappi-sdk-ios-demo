//
//  ViewController.m
//  AppDemoMoPub
//
//  Created by Itamar Menahem on 2/25/18.
//  Copyright © 2018 Itamar Menahem. All rights reserved.
//

#import "ViewController.h"

#define RewardedUnitID @"fb26490cb5cd450dae218ed683bae687"
#define InterstitialVideoUnitID @"29e889ae3315428087ef9b4bd72a5291"
#define InterstitialADUnitID @"3eb931acaa33483ebccab1505c0de78f"

#define MESSAGE_VIEW_HEIGHT 100

typedef NS_ENUM(NSUInteger, ButtonState)
{
    Load,
    Show,
    UnKnown
};

typedef NS_ENUM(NSUInteger, ButtonAdType)
{
    None,
    RewardedVideo,
    InterstitialVideo,
    InterstitialAd
};

@interface ViewController ()

@end

@implementation ViewController
{
    MPRewardedVideo *rewardedVideo;
    MPInterstitialAdController *interstitialVideo;
    MPInterstitialAdController *interstitialAd;
    
    __weak IBOutlet UIButton *_rewardedVideoButton;
    __weak IBOutlet UIButton *_interstitialVideoButton;
    __weak IBOutlet UIButton *_interstitialAdButton;
    
    __weak IBOutlet UIView *_messageView;
    __weak IBOutlet UILabel *_messageLabel;
    
    __weak IBOutlet NSLayoutConstraint *_messageViewBottomConstraint;
    
    ButtonState _rewardedVideoState;
    ButtonState _interstitialVideoState;
    ButtonState _interstitialAdState;
    
    BOOL _isAlertShown;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateButtonText:RewardedVideo text:@"Load"];
    [self updateButtonText:InterstitialVideo text:@"Load"];
    [self updateButtonText:InterstitialAd text:@"Load"];
    
    _rewardedVideoState = Load;
    _interstitialVideoState = Load;
    _interstitialAdState = Load;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showOrHideActivityIndicator:RewardedVideo flagShow:NO];
    [self showOrHideActivityIndicator:InterstitialVideo flagShow:NO];
    [self showOrHideActivityIndicator:InterstitialAd flagShow:NO];
    
    _messageView.layer.cornerRadius = 15.0;
    _messageView.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadRewardedVideo {
    
    // Initialize rewarded video before loading any ads.
    MPMoPubConfiguration *sdkConfig = [[MPMoPubConfiguration alloc] initWithAdUnitIdForAppInitialization:RewardedUnitID];
    
    sdkConfig.globalMediationSettings = @[];
//    sdkConfig.loggingLevel = MPLogLevelInfo;
//    sdkConfig.allowLegitimateInterest(BOOL);
//    sdkConfig.allowLegitimateInterest(BOOL);
//    sdkConfig.additionalNetworks(NSArray of class names);
//   sdkConfig.mediatedNetworkConfigurations(NSMutableDictionary of network configuration);
//    [[MoPub sharedInstance] initializeSdkWithConfiguration:sdkConfig completion:nil];
//    [[MoPub sharedInstance] initializeRewardedVideoWithGlobalMediationSettings:nil delegate:self];
    [[MoPub sharedInstance] initializeSdkWithConfiguration:sdkConfig completion:^{
        NSLog(@"SDK initialization complete");
        // SDK initialization complete. Ready to make ad requests.
    }];
    
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
    
- (ButtonState)buttonStateByType:(ButtonAdType)type
{
    switch (type)
    {
        case RewardedVideo:
        {
            return _rewardedVideoState;
        }
        case InterstitialVideo:
        {
            return _interstitialVideoState;
        }
        case InterstitialAd:
        {
            return _interstitialAdState;
        }
        default:
        return UnKnown;
    }
}

- (void)showOrHideLoadingView:(ButtonAdType)adType isReady:(BOOL)isReady
{
    if (isReady)
    {
        [self showOrHideActivityIndicator:adType flagShow: NO];
        [self updateButtonText:adType text: @"Show "];
        [self updateButtonState:adType state: Show];
    }
    else
    {
        [self showOrHideActivityIndicator:adType flagShow: YES];
    }
}

- (void)updateButtonText:(ButtonAdType)adType text:(NSString *)text
{
    [UIView performWithoutAnimation:^{
        
        switch (adType)
        {
            case RewardedVideo:
            {
                NSString *buttonText = [text stringByAppendingString:@" rewarded video"];
                [self->_rewardedVideoButton setTitle:buttonText forState:UIControlStateNormal];
                [self->_rewardedVideoButton layoutIfNeeded];
                break;
            }
            case InterstitialVideo:
            {
                NSString *buttonText = [text stringByAppendingString:@" interstitial video"];
                [self->_interstitialVideoButton setTitle:buttonText forState:UIControlStateNormal];
                [self->_interstitialVideoButton layoutIfNeeded];
                break;
            }
            case InterstitialAd:
            {
                NSString *buttonText = [text stringByAppendingString:@" interstitial ad"];
                [self->_interstitialAdButton setTitle:buttonText forState:UIControlStateNormal];
                [self->_interstitialAdButton layoutIfNeeded];
                break;
            }
            default:
            break;
        }
    }];
}

- (void)updateButtonState:(ButtonAdType)adType state:(ButtonState)state
{
    switch (adType)
    {
        case RewardedVideo:
        {
            _rewardedVideoState = state;
            break;
        }
        case InterstitialVideo:
        {
            _interstitialVideoState = state;
            break;
        }
        case InterstitialAd:
        {
            _interstitialAdState = state;
            break;
        }
        default:
            break;
    }
}

- (void)showOrHideActivityIndicator:(ButtonAdType)adType flagShow:(BOOL)flagShow
{
    UIActivityIndicatorView *indicator;
    switch (adType)
    {
        case RewardedVideo:
        {
            indicator = (UIActivityIndicatorView *)[self.view viewWithTag:111];
            break;
        }
        case InterstitialVideo:
        {
            indicator = (UIActivityIndicatorView *)[self.view viewWithTag:222];
            break;
        }
        case InterstitialAd:
        {
            indicator = (UIActivityIndicatorView *)[self.view viewWithTag:333];
            break;
        }
        default:
        break;
    }
    
    if (indicator)
    {
        if (flagShow)
        {
            indicator.hidden = NO;
            [indicator startAnimating];
        }
        else
        {
            indicator.hidden = YES;
            [indicator stopAnimating];
        }
    }
}
    
- (void)showAd:(ButtonAdType)adType
{
    switch (adType)
    {
        case RewardedVideo:
        {
            if ([MPRewardedVideo hasAdAvailableForAdUnitID:RewardedUnitID])
                [MPRewardedVideo presentRewardedVideoAdForAdUnitID:RewardedUnitID fromViewController:self withReward:nil];
            break;
        }
        case InterstitialVideo:
        {
            if (interstitialVideo.ready)
                [interstitialVideo showFromViewController:self];
            else
                NSLog(@"Ad wasn't ready");
            break;
        }
        case InterstitialAd:
        {
            if (interstitialAd.ready)
                [interstitialAd showFromViewController:self];
            else
                NSLog(@"Ad wasn't ready");
            break;
        }
        default:
            break;
    }
}

- (IBAction)loadOrShowButtonClicked:(UIButton *)sender
{
    ButtonAdType type = (ButtonAdType)sender.tag;
    
    switch (type)
    {
        case RewardedVideo:
        {
            if (_rewardedVideoState == Load)
            {
                [self loadRewardedVideo];
                [self showOrHideLoadingView:RewardedVideo isReady: [MPRewardedVideo hasAdAvailableForAdUnitID:RewardedUnitID]];
            }
            else
            {
                [self showAd:RewardedVideo];
            }
            break;
        }
        case InterstitialVideo:
        {
            if (_interstitialVideoState == Load)
            {
                [self loadInterstitialVideo];
                [self showOrHideLoadingView:InterstitialVideo isReady:interstitialVideo.ready];
            }
            else
            {
                [self showAd:InterstitialVideo];
            }
            break;
        }
        case InterstitialAd:
        {
            if (_interstitialAdState == Load)
            {
                [self loadInterstitialAd];
                [self showOrHideLoadingView:InterstitialAd isReady:interstitialAd.ready];
            }
            else
            {
                [self showAd:InterstitialAd];
            }
            break;
        }
        default:
        break;
    }
}

- (ButtonAdType)adTypeForUnitID:(NSString *)unitID
{
    if ([unitID.lowercaseString isEqualToString:RewardedUnitID])
        return RewardedVideo;
    if ([unitID.lowercaseString isEqualToString:InterstitialVideoUnitID])
        return InterstitialVideo;
    if ([unitID.lowercaseString isEqualToString:InterstitialADUnitID])
        return InterstitialAd;
    
    return RewardedVideo;
}

- (NSString *)productNameForUnitID:(NSString *)unitID
{
    if ([unitID.lowercaseString isEqualToString:RewardedUnitID])
        return @"Rewarded video";
    if ([unitID.lowercaseString isEqualToString:InterstitialVideoUnitID])
        return @"Interstitial video";
    if ([unitID.lowercaseString isEqualToString:InterstitialADUnitID])
        return @"Interstitial ad";
    
    return @"Rewarded video";
}

- (void)showAlert:(NSString *)message
{
    _messageLabel.text = message;
    
    if (_isAlertShown) return;
    
    _isAlertShown = YES;
    _messageViewBottomConstraint.constant = 5;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hideAlert) withObject:nil afterDelay:2];
    }];
}

- (void)hideAlert
{
    if (!_isAlertShown) return;
    
    _isAlertShown = NO;
    _messageViewBottomConstraint.constant = -MESSAGE_VIEW_HEIGHT;
    
    [UIView animateWithDuration:0.4 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self->_messageLabel.text = nil;
    }];
}

- (void)layoutAdRecieved:(NSString *)unitID
{
    ButtonAdType adType = [self adTypeForUnitID:unitID];
    [self showOrHideActivityIndicator:adType flagShow:NO];
    [self updateButtonText:adType text:@"Show"];
    [self updateButtonState:adType state:Show];
}

- (void)layoutAdReset:(NSString *)unitID
{
    ButtonAdType adType = [self adTypeForUnitID:unitID];
    [self showOrHideActivityIndicator:adType flagShow:NO];
    [self updateButtonText:adType text:@"Load"];
    [self updateButtonState:adType state:Load];
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

#pragma mark - MPInterstitialAdController delegate
    
- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial
{
    NSLog(@"interstitial Did Load Ad");
    
    [self layoutAdRecieved:interstitial.adUnitId];

    NSString *productName = [self productNameForUnitID:interstitial.adUnitId];
    NSString *message = [NSString stringWithFormat:@"%@ was loaded", productName];

    [self showAlert:message];
}
    
- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial
{
    NSLog(@"interstitial Did Fail To Load Ad");
    
    [self layoutAdReset:interstitial.adUnitId];

    NSString *productName = [self productNameForUnitID:interstitial.adUnitId];
    NSString *message = [NSString stringWithFormat:@"%@ was failed to load", productName];

    [self showAlert:message];
}
    
- (void)interstitialWillAppear:(MPInterstitialAdController *)interstitial
{
    NSLog(@"interstitial Will Appear");
}
    
- (void)interstitialDidAppear:(MPInterstitialAdController *)interstitial
{
    NSLog(@"interstitial Did Appear");
}
    
- (void)interstitialWillDisappear:(MPInterstitialAdController *)interstitial
{
    NSLog(@"interstitial Will Disappear");
    
    [self layoutAdReset:interstitial.adUnitId];
}
    
- (void)interstitialDidDisappear:(MPInterstitialAdController *)interstitial
{
    NSLog(@"interstitial Did Disappear");
}
    
- (void)interstitialDidExpire:(MPInterstitialAdController *)interstitial
{
    NSLog(@"interstitial Did Expire");
}
    
- (void)interstitialDidReceiveTapEvent:(MPInterstitialAdController *)interstitial
{
    NSLog(@"interstitial Did Receive Tap Event");
}
    
#pragma Mark - MPRewardedVideo Delegate

- (void)rewardedVideoAdDidLoadForAdUnitID:(NSString *)adUnitID
{
    NSLog(@"rewardedVideoAdDidLoadForAdUnitID %@",adUnitID);

    [self layoutAdRecieved:adUnitID];
    
    NSString *productName = [self productNameForUnitID:adUnitID];
    NSString *message = [NSString stringWithFormat:@"%@ was loaded", productName];
    
    [self showAlert:message];
}
    
- (void)rewardedVideoAdDidFailToLoadForAdUnitID:(NSString *)adUnitID error:(NSError *)error
{
    NSLog(@"rewardedVideoAdDidFailToLoadForAdUnitID %@",adUnitID);
    
    [self layoutAdReset:adUnitID];
    
    NSString *productName = [self productNameForUnitID:adUnitID];
    NSString *message = [NSString stringWithFormat:@"%@ was failed to load", productName];
    
    [self showAlert:message];
}
    
- (void)rewardedVideoAdWillAppearForAdUnitID:(NSString *)adUnitID
{
    NSLog(@"rewardedVideoAdWillAppearForAdUnitID %@",adUnitID);
}
    
- (void)rewardedVideoAdDidAppearForAdUnitID:(NSString *)adUnitID
{
    NSLog(@"rewardedVideoAdDidAppearForAdUnitID %@",adUnitID);
}
    
- (void)rewardedVideoAdWillDisappearForAdUnitID:(NSString *)adUnitID
{
    NSLog(@"rewardedVideoAdWillDisappearForAdUnitID %@",adUnitID);
    
    [self layoutAdReset:adUnitID];
}
    
- (void)rewardedVideoAdDidDisappearForAdUnitID:(NSString *)adUnitID
{
    NSLog(@"rewardedVideoAdDidDisappearForAdUnitID %@",adUnitID);
}
    
- (void)rewardedVideoAdDidExpireForAdUnitID:(NSString *)adUnitID
{
    NSLog(@"rewardedVideoAdDidExpireForAdUnitID %@",adUnitID);
}
    
- (void)rewardedVideoAdDidFailToPlayForAdUnitID:(NSString *)adUnitID error:(NSError *)error
{
    NSLog(@"rewardedVideoAdDidFailToPlayForAdUnitID %@",adUnitID);
}
    
- (void)rewardedVideoAdDidReceiveTapEventForAdUnitID:(NSString *)adUnitID
{
    NSLog(@"rewardedVideoAdDidReceiveTapEventForAdUnitID %@",adUnitID);
}
    
- (void)rewardedVideoAdWillLeaveApplicationForAdUnitID:(NSString *)adUnitID
{
    NSLog(@"rewardedVideoAdWillLeaveApplicationForAdUnitID %@",adUnitID);
}
    
- (void)rewardedVideoAdShouldRewardForAdUnitID:(NSString *)adUnitID reward:(MPRewardedVideoReward *)reward
{
    NSLog(@"rewardedVideoAdShouldRewardForAdUnitID %@",adUnitID);
}
    
@end

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
@property(nonatomic, strong) GADInterstitial *interstitialVideoAdMob;
@property(nonatomic, strong) GADInterstitial *interstitialAdAdMob;
@end

@implementation ViewController
{
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
    
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _messageViewBottomConstraint.constant = -(2*MESSAGE_VIEW_HEIGHT);

    [self updateButtonText:RewardedVideo text:@"Load"];
    [self updateButtonText:InterstitialVideo text:@"Load"];
    [self updateButtonText:InterstitialAd text:@"Load"];
    
    _rewardedVideoState = Load;
    _interstitialVideoState = Load;
    _interstitialAdState = Load;
    
    [self initAdMob];
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

- (void)initAdMob{
    [GADMobileAds.sharedInstance startWithCompletionHandler: nil];
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
            if ([[GADRewardBasedVideoAd sharedInstance] isReady])
                [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
            break;
        }
        case InterstitialVideo:
        {
            if (self.interstitialVideoAdMob.isReady)
                [self.interstitialVideoAdMob presentFromRootViewController:self];
            else
                NSLog(@"Ad wasn't ready");
            break;
        }
        case InterstitialAd:
        {
            if (self.interstitialAdAdMob.isReady)
                [self.interstitialAdAdMob presentFromRootViewController:self];
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
                [self loadRewardedVideoAdMob];
                [self showOrHideLoadingView:RewardedVideo isReady: [[GADRewardBasedVideoAd sharedInstance] isReady]];
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
                [self loadInterstitialVideoAdMob];
                [self showOrHideLoadingView:InterstitialVideo isReady:_interstitialVideoAdMob.isReady];
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
                [self loadInterstitialAdAdMob];
                [self showOrHideLoadingView:InterstitialAd isReady:_interstitialAdAdMob.isReady];
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
    if ([unitID.lowercaseString isEqualToString:RewardedUnitIDAdMob])
        return RewardedVideo;
    if ([unitID.lowercaseString isEqualToString:InterstitialVideoUnitIDAdMob])
        return InterstitialVideo;
    if ([unitID.lowercaseString isEqualToString:InterstitialADUnitIDAdMob])
        return InterstitialAd;
    
    return RewardedVideo;
}

- (NSString *)productNameForUnitID:(NSString *)unitID
{
    if ([unitID.lowercaseString isEqualToString:RewardedUnitIDAdMob])
        return @"Rewarded video";
    if ([unitID.lowercaseString isEqualToString:InterstitialVideoUnitIDAdMob])
        return @"Interstitial video";
    if ([unitID.lowercaseString isEqualToString:InterstitialADUnitIDAdMob])
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
    _messageViewBottomConstraint.constant = -(2*MESSAGE_VIEW_HEIGHT);
    
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

- (void)layoutAdFailed:(NSString *)unitID
{
    NSString *productName = [self productNameForUnitID:unitID];
    NSString *message = [NSString stringWithFormat:@"%@ was failed to load", productName];
    
    [self showAlert:message];
}
    
#pragma mark - interstitial ad mob Delegate

/// Tells the delegate an ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"interstitialDidReceiveAd");
    
    [self layoutAdRecieved:ad.adUnitID];
    
    NSString *productName = [self productNameForUnitID:ad.adUnitID];
    NSString *message = [NSString stringWithFormat:@"%@ was loaded", productName];
    
    [self showAlert:message];
}

/// Tells the delegate an ad request failed.
- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
    
    [self layoutAdFailed:ad.adUnitID];
}

/// Tells the delegate that an interstitial will be presented.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillPresentScreen");
}

/// Tells the delegate the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad
{
    NSLog(@"interstitialWillDismissScreen");
     
    [self layoutAdReset:ad.adUnitID];
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
    
    [self layoutAdRecieved:@""];
    
    NSString *message = @"Rewarded video was loaded";
    
    [self showAlert:message];
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Opened reward based video ad.");
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad started playing.");
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is closed.");
    
    [self layoutAdReset:RewardedUnitIDAdMob];
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad will leave application.");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    NSLog(@"Reward based video ad failed to load.");
    
    [self layoutAdFailed:@""];
    
    NSString *message = @"Rewarded video was failed to load";
    
    [self showAlert:message];
}

@end

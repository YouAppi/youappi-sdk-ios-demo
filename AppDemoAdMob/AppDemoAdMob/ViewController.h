//
//  ViewController.h
//  AppDemoAdMob
//
//  Created by Itamar Menahem on 2/14/18.
//  Copyright © 2018 Itamar Menahem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface ViewController : UIViewController <GADRewardBasedVideoAdDelegate, GADInterstitialDelegate>

- (IBAction)btnLoad:(UIButton *)sender;

- (IBAction)btnShow:(UIButton *)sender;

@end


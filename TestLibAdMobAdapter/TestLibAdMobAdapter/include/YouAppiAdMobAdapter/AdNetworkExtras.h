//
//  AdNetworkExtras.h
//  MoPub
//
//  Created by Itamar Menahem on 2/12/18.
//  Copyright © 2018 YouAppi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GADRewardBasedVideoAd.h>
@interface AdNetworkExtras : NSObject<GADAdNetworkExtras>
@property (nonatomic,strong) NSString *accessToken;
@property (nonatomic,strong) NSString *adUnitId;
@end

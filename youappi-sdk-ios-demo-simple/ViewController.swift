//
//  ViewController.swift
//  youappi-ios-sdk-demo-simple
//
//  Created by Guy Bashan on 3/30/17.
//  Copyright © 2017 YouAppi. All rights reserved.
//

import UIKit
import YouAppi

class ViewController: UIViewController, YAAdDelegate {
    
    @IBOutlet weak var buttonRewardedVideo: UIButton!
    @IBOutlet weak var buttonInterstitialVideo: UIButton!
    @IBOutlet weak var buttonInterstitialAd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Please note this is a demo access token.
        YouAppi.sharedInstance.initialize(accessToken: "821cfa77-3127-42b5-9e6b-0afcecf77c67")
        
        YouAppi.sharedInstance.rewardedVideo()?.delegate = self
        YouAppi.sharedInstance.interstitialVideo()?.delegate = self
        YouAppi.sharedInstance.cardAd()?.delegate = self
        
        self.updateLayout()
        
    }
    
    private func updateLayout() {
        self.buttonRewardedVideo?.isEnabled = YouAppi.sharedInstance.rewardedVideo()!.isAvailable()
        self.buttonInterstitialVideo?.isEnabled = YouAppi.sharedInstance.interstitialVideo()!.isAvailable()
        self.buttonInterstitialAd?.isEnabled = YouAppi.sharedInstance.cardAd()!.isAvailable()
    }
    
    @IBAction func showAd(sender: UIButton) {
        
        var adOpt: YAAd?
        
        switch sender.tag {
        case 1: adOpt = YouAppi.sharedInstance.rewardedVideo()
        case 2: adOpt = YouAppi.sharedInstance.interstitialVideo()
        case 3: adOpt = YouAppi.sharedInstance.cardAd()
        default: adOpt = nil
        }
        
        if let ad = adOpt {
            if (ad.isAvailable()) {
                ad.show()
            }
        }
        
    }
    
    //MARK: YAAd delegate
    
    internal func adDidInitialize(youAppi: YouAppi, adType: AdType) {
        print("\(adType) did initialize")
    }
    
    internal func adWillLeaveApplication(youAppi: YouAppi, adType: AdType) {
        print("\(adType) ad will leave application")
    }
    
    internal func adDidChangeAvailability(youAppi: YouAppi, adType: AdType, isAvailable: Bool) {
        print("\(adType) did Change availablity")
        
        self.updateLayout()
    }
    
    func adRetrievalFailed(youAppi: YouAppi, adType: AdType, error: Error) {
        print("\(adType) Failed to retrieve ad: \(error)")
    }
    
    // MARK: YouAppi Delegates
    
    func adDidClicked(youAppi: YouAppi, adType: AdType) {
        print("\(adType) did Clicked")
    }
    
    func adDidShown(youAppi: YouAppi, adType: AdType) {
        print("\(adType) did Shown")
        
    }
    
    func adDidClose(youAppi: YouAppi, adType: AdType) {
        print("\(adType) did Closed")
        
    }
    
    func adPreloadFailed(youAppi: YouAppi, adType: AdType, error: Error) {
        print("\(adType) Failed preloading ad: \(error)")
    }
    
    func adDidEnd(youAppi: YouAppi, adType: AdType) {
        print("\(adType) did End")
        
    }
    
    func adDidStarted(youAppi: YouAppi, adType: AdType) {
        print("\(adType) did Started")
        
    }
    
    func adDidRewarded(youAppi: YouAppi, adType: AdType) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


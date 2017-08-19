//
//  ViewController.swift
//  youappi-ios-sdk-demo-simple
//
//  Created by Guy Bashan on 3/30/17.
//  Copyright © 2017 YouAppi. All rights reserved.
//

import UIKit
import YouAppi

class ViewController: UIViewController, YAAdDelegate, YALoggerDelegate {
    
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
        YouAppi.sharedInstance.log()?.delegate = self
        
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
    internal func adDidInitialize() {
        print("did initialize")
        
        self.updateLayout()
    }
    
    internal func adWillLeaveApplication() {
        print("ad will leave application")
    }
    
    internal func adDidChangeAvailability(isAvailable: Bool) {
        print("did Change availablity")
        
        self.updateLayout()
    }
    
    func adRetrievalFailed(error: Error) {
        print("Failed to retrieve ad: \(error)")
    }
    
    // MARK: YouAppi Delegates
    
    func adDidClicked() {
        print("did Clicked")
    }
    
    func adDidShown() {
        print("did Shown")
        
    }
    
    func adDidClose() {
        print("did Closed")
        
    }
    
    func adPreloadFailed(error: Error) {
        print("Failed preloading ad: \(error)")
    }
    
    func adDidEnd() {
        print("did End")
        
    }
    
    func adDidStarted() {
        print("did Started")
        
    }
    
    func adDidRewarded() {
        print("ad was rewarded")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logDidReceivedInformation(message: String, error: Error?) {
        let err = error?.localizedDescription ?? ""
        print("\(message), error: \(err)")
    }
    
}


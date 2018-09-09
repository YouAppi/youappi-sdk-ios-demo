//
//  ViewController.swift
//  AppDemo
//
//  Created by YouAppi.
//  Copyright © 2018 YouAppi. All rights reserved.
//

import UIKit
import YouAppiMoat

enum ButtonState {
    case Load
    case Show
    case UnKnown
}

enum ButtonAdType: Int {
    case None
    case RewardedVideo
    case InterstitialVideo
    case InterstitialAd
}

class ViewController: UIViewController, YALoggerDelegate, YAAdInterstitialAdDelegate, YAAdRewardedVideoDelegate, YAAdInterstitialVideoDelegate {
    let product_rewarded_video = "Rewarded Video"
    let product_interstitial_video = "Interstitial Video"
    let product_interstitial_ad = "Interstitial Ad"
    
    var rewardedVideoId = "rewarded_video_test_ios"
    var interstitialVideoId = "interstitial_video_test_ios"
    var interstitialAdId = "interstitial_ad_test_ios"
    
    var rewardedVideo: YAAdRewardedVideo?
    var interstitialVideo: YAAdInterstitialVideo?
    var interstitialAd: YAAdCard?
    
    var alert: AlertToast?
    var dictToKeepTrackOfProductTypeForEveryUnitAdID: [String:String]!
    
    @IBOutlet weak var buttonRewardedVideo: UIButton!
    @IBOutlet weak var buttonInterstitialVideo: UIButton!
    @IBOutlet weak var buttonInterstitialAd: UIButton!
    @IBOutlet weak var viewMsg: UIView!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var viewMsgCon: NSLayoutConstraint!
    @IBOutlet weak var versionLabel: UILabel!
    
    var buttonRewardedVideoState: ButtonState!
    var buttonInterstitialVideoState: ButtonState!
    var buttonInterstitialAdtate: ButtonState!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Please note this is a demo access token. Change it to your in order to see ads relevant to your app.
        YouAppi.initialize(accessToken:"821cfa77-3127-42b5-9e6b-0afcecf77c67", userConsent: true)
        YouAppi.sharedInstance.ageRestrictedUser = false
        let version = ("Version: " + YouAppi.sdkVersion())
        self.versionLabel.text = version
    
        print("Environment: " + YouAppi.sharedInstance.environment)
        print(version)
        
        YouAppi.sharedInstance.logLevel(.all)
        YouAppi.sharedInstance.log()?.delegate = self
        
        self.dictToKeepTrackOfProductTypeForEveryUnitAdID = [String:String]()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.enableOrDisableButton(flag: true)
        self.updateButtonText(adType: .RewardedVideo, text: "Load ")
        self.updateButtonText(adType: .InterstitialVideo, text: "Load ")
        self.updateButtonText(adType: .InterstitialAd, text: "Load ")
        
        buttonRewardedVideoState = .Load
        buttonInterstitialVideoState = .Load
        buttonInterstitialAdtate = .Load
        
        self.showOrHideActivityIndictor(adType: .RewardedVideo)
        self.showOrHideActivityIndictor(adType: .InterstitialVideo)
        self.showOrHideActivityIndictor(adType: .InterstitialAd)
        
        self.alert = AlertToast(view: self.view, viewMsg: self.viewMsg, lblMsg: self.lblMsg, viewMsgCon: self.viewMsgCon)
        self.alert?.hideAlert()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    //MARK: Private Functions delegate
    
    private func enableOrDisableButton(flag: Bool) {
        self.buttonRewardedVideo?.isEnabled = flag
        self.buttonInterstitialVideo?.isEnabled = flag
        self.buttonInterstitialAd?.isEnabled = flag
        self.buttonRewardedVideo.alpha = flag ? 1.0 : 0.2
        self.buttonInterstitialVideo.alpha = flag ? 1.0 : 0.2
        self.buttonInterstitialVideo.alpha = flag ? 1.0 : 0.2
    }
    
    private func updateButtonState(by adType: ButtonAdType, state: ButtonState) {
        switch adType
        {
            case .RewardedVideo:
                 self.buttonRewardedVideoState = state
            case .InterstitialVideo:
                 self.buttonInterstitialVideoState = state
            case .InterstitialAd:
                 self.buttonInterstitialAdtate = state
            default:
                print("No state for this button")
        }
    }
    
    private func updateButtonText(adType: ButtonAdType, text: String) {
        UIView.performWithoutAnimation {
            switch adType
            {
                case .RewardedVideo:
                    self.buttonRewardedVideo?.setTitle(text + product_rewarded_video, for: .normal)
                    self.buttonRewardedVideo.layoutIfNeeded()
                case .InterstitialVideo:
                    self.buttonInterstitialVideo?.setTitle(text + product_interstitial_video, for: .normal)
                    self.buttonInterstitialVideo.layoutIfNeeded()
                case .InterstitialAd:
                    self.buttonInterstitialAd?.setTitle(text + product_interstitial_ad, for: .normal)
                    self.buttonInterstitialAd.layoutIfNeeded()
                default:
                    return
            }
        }
    }
    
    private func removeProduct(with adUnitID: String) {
        self.dictToKeepTrackOfProductTypeForEveryUnitAdID.removeValue(forKey: adUnitID)
        if adUnitID == rewardedVideoId {
            self.rewardedVideo = nil
            self.updateButtonText(adType: .RewardedVideo, text: "Load ")
            self.updateButtonState(by: .RewardedVideo, state: .Load)
        }
        else if adUnitID == interstitialVideoId {
            self.interstitialVideo = nil
            self.updateButtonText(adType: .InterstitialVideo, text: "Load ")
            self.updateButtonState(by: .InterstitialVideo, state: .Load)
        }
        else if adUnitID == interstitialAdId {
            self.interstitialAd = nil
            self.updateButtonText(adType: .InterstitialAd, text: "Load ")
            self.updateButtonState(by: .InterstitialAd, state: .Load)
        }
    }
    
    private func adType(by adUnitID: String) -> ButtonAdType
    {
        if adUnitID.contains(rewardedVideoId) {
            return .RewardedVideo
        }
        else if adUnitID.contains(interstitialVideoId) {
            return .InterstitialVideo
        }
        else if adUnitID.contains(interstitialAdId) {
            return .InterstitialAd
        }
        return .None
    }
    
    private func productType(for adUnitID: String?) -> String {
        guard let unitID = adUnitID else {
            return ""
        }
        if let name = self.dictToKeepTrackOfProductTypeForEveryUnitAdID[unitID] {
            return name
        }
        return ""
    }
 
    private func showAlert(message: String) {
        self.alert?.showAlert(message: message)
    }
    
    private func showOrHideActivityIndictor(adType: ButtonAdType, flagShow: Bool = false) {
        var indicator: UIActivityIndicatorView?
        switch adType {
            case .RewardedVideo:
                indicator = self.view!.viewWithTag(111) as? UIActivityIndicatorView
            case .InterstitialVideo:
                indicator = self.view!.viewWithTag(222) as? UIActivityIndicatorView
            case .InterstitialAd:
                indicator = self.view!.viewWithTag(333) as? UIActivityIndicatorView
            default:
                return
        }
        
        guard let indView = indicator else {
            return
        }
        if flagShow == true {
            indView.isHidden = false
            indView.startAnimating()
        } else {
            indView.isHidden = true
            indView.stopAnimating()
        }
    }
    
    private func buttonState(by type: ButtonAdType) -> ButtonState {
        switch type {
            case .RewardedVideo:
                return self.buttonRewardedVideoState
            case .InterstitialVideo:
                return self.buttonInterstitialVideoState
            case .InterstitialAd:
                return self.buttonInterstitialAdtate
            default:
                print("no state for this  button")
        }
        return .UnKnown
    }
    
    
    @IBAction func showAd(sender: UIButton) {
        var adOpt: YAAd?
        guard let adType: ButtonAdType = ButtonAdType(rawValue: sender.tag) else {
            return
        }
        
        switch adType {
            case .RewardedVideo:
                if self.buttonRewardedVideoState == .Load {
                    if (self.rewardedVideo == nil) {
                        self.rewardedVideo = YouAppi.sharedInstance.rewardedVideo(rewardedVideoId)}
                    self.dictToKeepTrackOfProductTypeForEveryUnitAdID[rewardedVideoId] = self.product_rewarded_video
                    self.rewardedVideo?.delegate = self
                    
                    // Add custom parameters to be received on server-to-server completion callback (optional)
                    let adRequest = YAAdRequest()
                    adRequest.addCustomParam(paramKey: "user_id", paramValue: "user1")
                    adRequest.addCustomParam(paramKey: "reward_type", paramValue: "coins")
                    adRequest.addCustomParam(paramKey: "reward_value", paramValue: "25")
                    self.rewardedVideo?.adRequest = adRequest
                    
                    self.rewardedVideo?.load()
                }
                adOpt = self.rewardedVideo
            case .InterstitialVideo:
                if buttonInterstitialVideoState == .Load {
                    if (interstitialVideo == nil) {
                        self.interstitialVideo = YouAppi.sharedInstance.interstitialVideo(interstitialVideoId)}
                    self.dictToKeepTrackOfProductTypeForEveryUnitAdID[interstitialVideoId] = self.product_interstitial_video
                    self.interstitialVideo?.delegate = self
                    self.interstitialVideo?.load()
                }
                adOpt = self.interstitialVideo
            case .InterstitialAd:
                if buttonInterstitialAdtate == .Load {
                    if (interstitialAd == nil){
                        self.interstitialAd = YouAppi.sharedInstance.interstitialAd(interstitialAdId)}
                    self.dictToKeepTrackOfProductTypeForEveryUnitAdID[interstitialAdId] = self.product_interstitial_ad
                    self.interstitialAd?.delegate = self
                    self.interstitialAd?.load()
                }
                adOpt = self.interstitialAd
            default:
                return
        }
        
        if self.buttonState(by: adType) == .Load {
            if let ad = adOpt {
                if (ad.isAvailable()) {
                    self.showOrHideActivityIndictor(adType: adType, flagShow: false)
                    self.updateButtonText(adType: adType, text:"Show ")
                    self.updateButtonState(by: adType, state: .Show)
                } else {
                    self.showOrHideActivityIndictor(adType: adType, flagShow: true)
                }
            }
        } else {
            if let ad = adOpt {
                if (ad.isAvailable()) {
                    ad.show()
                }
            }
        }
    }
  
    //MARK: YouAppi Delegates
    
    func onAdStarted(adUnitID: String) {
        print("onAdStarted - Ad Unit ID: \(adUnitID)")
    }
    
    func onAdEnded(adUnitID: String) {
        self.removeProduct(with: adUnitID)
        print("onAdEnded - Ad Unit ID: \(adUnitID)")
    }
    
    func onAdClick(adUnitID: String) {
        print("onAdClick: \(adUnitID)")
    }
    
    internal func onLoadSuccess(adUnitID: String) {
        let productName: String = self.productType(for: adUnitID)
        let message = "\(productName) was loaded, Ad Unit Id: \(adUnitID)"
        let adType: ButtonAdType = self.adType(by: adUnitID)
        self.showOrHideActivityIndictor(adType: adType)
        self.updateButtonText(adType: adType, text: "Show ")
        self.updateButtonState(by: adType, state: .Show)
        print(message)
        self.showAlert(message: message)
    }
    
    internal func onCardWillLeaveApplication(adUnitID: String) {
        print("onCardWillLeaveApplication - Ad Unit ID: \(adUnitID)")
    }
    
    func onLoadFailure(adUnitID: String, errorCode: YAErrorCode, error: Error?) {
        let productName: String = self.productType(for: adUnitID)
        let buttonAdType: ButtonAdType = self.adType(by: adUnitID)
        self.showOrHideActivityIndictor(adType: buttonAdType)
        self.updateButtonText(adType: buttonAdType, text: "Load ")
        self.updateButtonState(by: buttonAdType, state: .Load)
        let errorCodeInfo = errorCode.description()
        let errorMessage = "Failed to load \(productName), Ad Unit ID: \(adUnitID), Error code: \(errorCodeInfo)"
        print(errorMessage)
        self.showAlert(message: errorMessage)
    }

    func onCardShow(adUnitID: String) {
        print("onCardShow - Ad Unit ID: \(adUnitID)")
    }
    
    func onCardClose(adUnitID: String) {
        self.removeProduct(with: adUnitID)
        print("onCardClose - AD Unit ID: \(adUnitID)")
    }
    
    func onRewarded(adUnitID: String) {
        let message = "Rewarded video granted!"
        self.removeProduct(with: adUnitID)
        self.showAlert(message: message)
        print(message)
    }
    
    func onVideoStarted(adUnitID: String) {
        print("onVideoStarted - Unit ID: \(adUnitID)")
    }
    
    func onVideoEnded(adUnitID: String) {
        print("onVideoEnded - Ad Unit ID: \(adUnitID)")
    }
    
    func onAdLeftApplication(adUnitID: String) {
        print("onAdLeftApplication: - Ad Unit ID: \(adUnitID)")
    }
    
    func onShowFailure(adUnitID: String, errorCode: YAErrorCode,error: Error?) {
        let productName: String = self.productType(for: adUnitID)
        let errorCodeInfo = errorCode.description()
        let errorMessage = "Failed to show \(productName), Ad Unit ID: \(adUnitID), Error code: \(errorCodeInfo)"
        print(errorMessage)
        self.showAlert(message: errorMessage)
    }
    
    // MARK: YALogger Delegate
    
    func logDidReceivedInformation(youAppi: YouAppi, tag: YALogTag, logLevel: YALogLevel, message: String, error: Error?)
    {
        /*
         switch logLevel
         {
         case .none:
         print(logLevel.descriptionAsString())
         case .all:
         print(logLevel.descriptionAsString())
         case .debug:
         print(logLevel.descriptionAsString())
         case .info:
         print(logLevel.descriptionAsString())
         case .warning:
         print(logLevel.descriptionAsString())
         case .error:
         print(logLevel.descriptionAsString())
         }
         */
    }
}

    



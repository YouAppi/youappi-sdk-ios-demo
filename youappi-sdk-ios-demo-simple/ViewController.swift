//
//  ViewController.swift
//  youappi-ios-sdk-demo-simple
//
//  Created by Guy Bashan on 3/30/17.
//  Copyright © 2017 YouAppi. All rights reserved.
//

import UIKit
import YouAppi

enum ButtonState {
    case Load
    case Show
    case UnKnown
   
}

class ViewController: UIViewController, YALoggerDelegate,YAAdCardDelegate  {
    
     let product_rewarded_video = "rewarded video"
     let product_interstitial_video = "interstitial video"
     let product_interstitial_ad = "interstitial ad"
    
     var rewardedVideoId = "rewarded_video_test_ios"
     var interstitialVideoId = "interstitial_video_test_ios"
     var interstitialAdId = "interstitial_ad_test_ios"
    
    var rewardedVideo: YAAdRewardedVideo?
    var interstitialVideo: YAAdInterstitialVideo?
    var interstitialAd: YAAdCard?
    
    var alert:AlertToast?
    
    var dictToKeepTrackOfProductTypeForEveryUnitAdID:[String:String]!
    
    @IBOutlet weak var buttonRewardedVideo: UIButton!
    @IBOutlet weak var buttonInterstitialVideo: UIButton!
    @IBOutlet weak var buttonInterstitialAd: UIButton!
    @IBOutlet weak var viewMsg: UIView!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var viewMsgCon: NSLayoutConstraint!
    
    var buttonRewardedVideoState:ButtonState!
    var buttonInterstitialVideoState:ButtonState!
    var buttonInterstitialAdtate:ButtonState!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Please note this is a demo access token.
        YouAppi.sharedInstance.initialize(accessToken: "821cfa77-3127-42b5-9e6b-0afcecf77c67")
        
        YouAppi.sharedInstance.log()?.delegate = self
        
        self.dictToKeepTrackOfProductTypeForEveryUnitAdID = [String:String]()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.enableOrDisableButton(flag: true)
        self.setButtonText(tag:1,text:"Load ")
        self.setButtonText(tag:2,text:"Load ")
        self.setButtonText(tag:3,text:"Load ")
        
        buttonRewardedVideoState = .Load
        buttonInterstitialVideoState = .Load
        buttonInterstitialAdtate = .Load
        
        self.alert = AlertToast(view: self.view, viewMsg: self.viewMsg, lblMsg: self.lblMsg, viewMsgCon: self.viewMsgCon)
        self.alert?.hideAlert()
        
        self.showOrHideActivityIndictor(buttonTag: 1, flagShow: false)
        self.showOrHideActivityIndictor(buttonTag: 2, flagShow: false)
        self.showOrHideActivityIndictor(buttonTag: 3, flagShow: false)
        
        self.viewMsg.layer.cornerRadius = 15.0
        self.viewMsg.clipsToBounds = true
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }

    //MARK: Private Functions delegate
    
    
    private func enableOrDisableButton(flag:Bool){
        
        self.buttonRewardedVideo?.isEnabled = flag
        self.buttonInterstitialVideo?.isEnabled = flag
        self.buttonInterstitialAd?.isEnabled = flag
        
        self.buttonRewardedVideo.alpha = flag ? 1.0 : 0.2
        self.buttonInterstitialVideo.alpha = flag ? 1.0 : 0.2
        self.buttonInterstitialVideo.alpha = flag ? 1.0 : 0.2
        
    }
    
    private func setButtonStateByTag(tag:Int,state:ButtonState){
        switch tag {
        case 1:
             self.buttonRewardedVideoState = state
            break
        case 2:
             self.buttonInterstitialVideoState = state
            break
        case 3:
             self.buttonInterstitialAdtate = state
            break
        default:
            print("no state for this  button")
        }
    }
    
    private func setButtonText(tag:Int,text:String) {
        
        switch tag {
        case 1:
             self.buttonRewardedVideo?.setTitle(text + product_rewarded_video, for: .normal)
            break
        case 2:
            self.buttonInterstitialVideo?.setTitle(
                text + product_interstitial_video, for: .normal)
            break
        case 3:
            self.buttonInterstitialAd?.setTitle(text + product_interstitial_ad, for: .normal)
            break
        default:
            return
        }
    }
    
    
    private func removeProduct(with adUnitID: String){
        
        self.dictToKeepTrackOfProductTypeForEveryUnitAdID.removeValue(forKey: adUnitID)
        
        if adUnitID == rewardedVideoId
        {
            self.self.rewardedVideo = nil
            self.setButtonText(tag: 1, text: "Load ")
            self.setButtonStateByTag(tag: 1, state: .Load)
        }
        else
            if adUnitID == interstitialVideoId
            {
                self.interstitialVideo = nil
                self.setButtonText(tag: 2, text: "Load ")
                self.setButtonStateByTag(tag: 2, state: .Load)
            }
            else
                if adUnitID == interstitialAdId
                {
                    self.interstitialAd = nil
                    self.setButtonText(tag: 3, text: "Load ")
                    self.setButtonStateByTag(tag: 3, state: .Load)
        }
    }
    
    private func getButtonTagByAdUnitId(with adUnitID: String) -> Int{
        
        if adUnitID.contains(rewardedVideoId){
            return 1
        }
        else if adUnitID.contains(interstitialVideoId){
                return 2
            }
        return 3 // interstitialAdId
    }
    
    private func productType(for adUnitID: String?) -> String
    {
        
        guard let unitID = adUnitID else
        {
            return ""
        }
     
        if let name = self.dictToKeepTrackOfProductTypeForEveryUnitAdID[unitID] {
            return name
        }
        
        return ""
    }

    private func showSetAdUnitId(){
        
        let alertController = UIAlertController(title: "Enter Unit Ad ID", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: {
            alert -> Void in
            
            let txt1 = alertController.textFields![0] as UITextField
            let txt2 = alertController.textFields![1] as UITextField
            let txt3 = alertController.textFields![2] as UITextField

            let text1_trim = txt1.text!.trimmingCharacters(in:NSCharacterSet.whitespaces) as  String
            let text2_trim = txt2.text!.trimmingCharacters(in:NSCharacterSet.whitespaces) as  String
            let text3_trim = txt3.text!.trimmingCharacters(in:NSCharacterSet.whitespaces) as  String
            
            if text1_trim.count != 0{
              
                self.rewardedVideoId =  text1_trim
               
            }
            if text2_trim.count != 0{
                
                self.interstitialVideoId = text2_trim
                
            }
            if text3_trim.count != 0{
       
                self.interstitialAdId = text3_trim
            }
   
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "test_ios_rewarded_video"
            textField.text = self.rewardedVideoId
            
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "test_ios_interstitial_video"
            textField.text = self.interstitialVideoId
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "test_ios_interstitial_ad"
            textField.text = self.interstitialAdId
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showAlert(message: String)
    {
        self.alert?.showAlert(message: message)
    }
    
    private func showOrHideActivityIndictor(buttonTag:Int,flagShow:Bool){
        
        var indicator: UIActivityIndicatorView?
        
        switch buttonTag{
        case 1:
            indicator = self.view!.viewWithTag(111) as? UIActivityIndicatorView
            break
        case 2:
            indicator = self.view!.viewWithTag(222) as? UIActivityIndicatorView
          break
        case 3:
            indicator = self.view!.viewWithTag(333) as? UIActivityIndicatorView
          break
        default:
            return
        }
        
        guard let indView = indicator else {
            return
        }
        if flagShow == true{
            indView.isHidden = false
            indView.startAnimating()
        }
        else{
            indView.stopAnimating()
            indView.isHidden = true
        }

    }
    
    private func getButtonStateByTag(tag:Int) -> ButtonState{
        switch tag {
        case 1:
            return self.buttonRewardedVideoState

        case 2:
            return self.buttonInterstitialVideoState

        case 3:
            return self.buttonInterstitialAdtate

        default:
            print("no state for this  button")
            
        }
        return .UnKnown
    }
    
    //MARK: Actions
    
    
    @IBAction func btnSetUnitsAdIDs(_ sender: UIButton) {
        self.showSetAdUnitId()
    }
    
    
    @IBAction func showAd(sender: UIButton) {
        
        var adOpt: YAAd?
        
        switch sender.tag {
            
        case 1:
            if self.buttonRewardedVideoState == .Load {
                self.rewardedVideo = YouAppi.sharedInstance.rewardedVideo(rewardedVideoId)
                self.dictToKeepTrackOfProductTypeForEveryUnitAdID[rewardedVideoId] = self.product_rewarded_video
                self.rewardedVideo?.delegate = self
                self.rewardedVideo?.load();
            }
            adOpt = self.rewardedVideo
            break
        case 2:
            if buttonInterstitialVideoState == .Load {
                self.interstitialVideo = YouAppi.sharedInstance.interstitialVideo(interstitialVideoId)
                self.dictToKeepTrackOfProductTypeForEveryUnitAdID[interstitialVideoId] = self.product_interstitial_video
                self.interstitialVideo?.delegate = self
                self.interstitialVideo?.load();
            }
            adOpt = self.interstitialVideo
            break
        case 3:
            if buttonInterstitialAdtate == .Load {
                self.interstitialAd = YouAppi.sharedInstance.interstitialAd(interstitialAdId)
                self.dictToKeepTrackOfProductTypeForEveryUnitAdID[interstitialAdId] = self.product_interstitial_ad
                self.interstitialAd?.delegate = self
                self.interstitialAd?.load();
            }
            adOpt = self.interstitialAd
            break
        default: return
        }
        
        if self.getButtonStateByTag(tag: sender.tag) == .Load{
            if let ad = adOpt {
                if (ad.isAvailable()) {
                    self.showOrHideActivityIndictor(buttonTag: sender.tag, flagShow: false)
                    self.setButtonText(tag: sender.tag, text:"Show ")
                    self.setButtonStateByTag(tag: sender.tag, state: .Show)
                }
                else{
                    self.showOrHideActivityIndictor(buttonTag: sender.tag ,flagShow: true)
                }
                
            }
        }
        else{
            
            if let ad = adOpt {
                if (ad.isAvailable()) {
                    ad.show()
                }
            }
        }
    }
    
  
    //MARK: YAAd delegate
    
    func onAdStarted(adUnitID: String)
    {
        print("Ad Show Started - Unit ID: \(adUnitID)")
    }
    
    func onAdEnded(adUnitID: String)
    {
        print("Ad Show Ended - Unit ID: \(adUnitID)")
    }
    
    internal func onLoadSuccess(adUnitID: String)
    {
        let productName: String = self.productType(for: adUnitID)
        let message = "\(productName) was loaded"
        
        let buttonTag = self.getButtonTagByAdUnitId(with: adUnitID)
        self.showOrHideActivityIndictor(buttonTag: buttonTag, flagShow:false )
        self.setButtonText(tag: buttonTag, text: "Show ")
        self.setButtonStateByTag(tag: buttonTag, state: .Show)
        
        print(message)
        self.showAlert(message: message)
    }
    
    internal func onCardWillLeaveApplication(adUnitID: String)
    {
        print("Interstitial Ad will leave application - Unit ID: \(adUnitID)")
    }
    
    // MARK: YouAppi Delegates
    
    func onLoadFailure(adUnitID: String, errorCode: YAErrorCode, error: Error)
    {
        if errorCode != .WARMING_UP && errorCode != .AD_IS_ALREADY_LOADED
        {
            self.removeProduct(with :adUnitID)
        }
        let productName: String = self.productType(for: adUnitID)
        
        let buttonTag = self.getButtonTagByAdUnitId(with: adUnitID)
        self.showOrHideActivityIndictor(buttonTag: buttonTag, flagShow: false)
        self.setButtonText(tag: buttonTag, text: "Load ")
        self.setButtonStateByTag(tag: buttonTag, state: .Load)

        let errorCodeInfo = errorCode.description()
        let errorMessage = "Failed to retrieve \(productName), Error code: \(errorCodeInfo)"
        print(errorMessage)
        
        self.showAlert(message: errorMessage)
    }

    func onCardShow(adUnitID: String)
    {
        print("Interstitial Ad did Shown - Unit ID: \(adUnitID)")
    }
    
    func onCardClose(adUnitID: String)
    {
        self.removeProduct(with: adUnitID)
        print("Interstitial Ad did Closed - Unit ID: \(adUnitID)")
    }
    
    func onPreloadFailed(adUnitID: String, errorCode: YAErrorCode, error: Error)
    {
        self.removeProduct(with: adUnitID)
        
        let buttonTag = self.getButtonTagByAdUnitId(with: adUnitID)
        self.showOrHideActivityIndictor(buttonTag: buttonTag, flagShow: false)
        self.setButtonText(tag: buttonTag, text: "Load ")
        self.setButtonStateByTag(tag: buttonTag, state: .Load)
        let productName: String = self.productType(for: adUnitID)
        let errorCodeInfo = errorCode.description()
        let errorMessage = "\(productName) preload Failed, Error:, Error code: \(errorCodeInfo)"
        print(errorMessage)
        
        self.showAlert(message: errorMessage)
    }
    
    func onRewarded(adUnitID: String)
    {
        self.removeProduct(with: adUnitID)
        
        self.showAlert(message: "Rewarded Video granted!")
        print("Rewarded Video granted")
    }
    
    func onVideoStarted(adUnitID: String)
    {
        print("Video Did Started - Unit ID: \(adUnitID)")
    }
    
    func onVideoEnded(adUnitID: String)
    {
        print("Video Did End - Unit ID: \(adUnitID)")
    }
    
    func onShowFailure(adUnitID: String, errorCode: YAErrorCode, error: Error)
    {
        if errorCode != .WARMING_UP
        {
            self.removeProduct(with :adUnitID)
        }
        let productName: String = self.productType(for: adUnitID)
        
        let errorCodeInfo = errorCode.description()
        let errorMessage = "Failed to show \(productName), Error code: \(errorCodeInfo)"
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

    



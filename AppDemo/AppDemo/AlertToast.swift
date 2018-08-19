//
//  AlertToast.swift
//  AppDemo
//
//  Created by YouAppi.
//  Copyright © 2018 YouAppi. All rights reserved.
//

import UIKit

class AlertToast: NSObject {
     var viewMsg: UIView!
     var lblMsg: UILabel!
     var viewMsgCon: NSLayoutConstraint!
     var view:UIView
     var timer:Timer?
    
     init(view:UIView , viewMsg:UIView , lblMsg:UILabel , viewMsgCon:NSLayoutConstraint){
        self.view = view
        self.lblMsg = lblMsg
        self.viewMsgCon = viewMsgCon
        self.viewMsg = viewMsg
    }
    
    func showAlert(message: String)
    {
        self.timer?.invalidate()
        self.lblMsg.text = message
        self.lblMsg.sizeToFit()
        self.viewMsgCon.constant = 20
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        }) {(comp ) in
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: (#selector(self.hideAlert)), userInfo: nil, repeats: false)
        }
    }
    
    @objc func hideAlert(){
        self.viewMsgCon.constant = ((-1) * self.viewMsg.frame.size.height)
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded();
        }
    }
}

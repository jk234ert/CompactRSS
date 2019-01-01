//
//  HUD.swift
//  CompactRss
//
//  Created by jk234ert on 2019/1/1.
//  Copyright © 2019 Brad. All rights reserved.
//

import UIKit
import SVProgressHUD

class HUD {
    class func showInfo(_ info: String) {
        performInMainQueue {
            SVProgressHUD.showInfo(withStatus: info)
        }
    }
    
    class func showError(_ error: String) {
        performInMainQueue {
            SVProgressHUD.showError(withStatus: error)
        }
    }
    
    class func showLoading() {
        performInMainQueue {
            SVProgressHUD.show(withStatus: "Loading...")
        }
    }
    
    class func hide() {
        performInMainQueue {
            SVProgressHUD.dismiss()
        }
    }
    
    private class func performInMainQueue(_ block: @escaping (() -> Void)) {
        DispatchQueue.main.async(execute: block)
    }
}

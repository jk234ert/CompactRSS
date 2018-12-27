//
//  ApplicationManager.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/27.
//  Copyright © 2018 Brad. All rights reserved.
//

import Foundation
import XCGLogger

class ApplicationManager: NSObject {
    
    static func applicationConfigInit(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        //MARK: Logger should be initialised at FIRST
        initLogger()
        initServices(application, launchOptions: launchOptions)
        
        initPersistentData()
        initUserDefaults()
        
        setupAppearance()
    }
    
    private static func initServices(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
//        Analytics.initServices(launchOptions: launchOptions)
//        RateManager.setupRate()
//        let _ = NamaManager.share()
//        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
//
//        Networking.setupHeaderProvide(CurrentUserInstance)
//        #if STAGING
//        NetworkingConstants.currentEnvironment = .Staging
//        #elseif ALPHA
//        NetworkingConstants.currentEnvironment = .Alpha
//        #else
//        NetworkingConstants.currentEnvironment = .AppStore
//        #endif
    }
    
    private static func initLogger() {
        let _ = log
    }
    
    private static func initPersistentData() {
        
    }
    
    private static func initUserDefaults() {
        
    }
    
    private static func setupAppearance() {
        
    }
    
}

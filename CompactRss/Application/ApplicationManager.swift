//
//  ApplicationManager.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/27.
//  Copyright © 2018 Brad. All rights reserved.
//

import Foundation
import XCGLogger
import SwifterSwift

let logger = XCGLogger(identifier: "mainLogger", includeDefaultDestinations: false)

class ApplicationManager: NSObject {
    
    class func applicationConfigInit(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        //MARK: Logger should be initialised at FIRST
        initLogger()
        initServices(application, launchOptions: launchOptions)
        
        initPersistentData()
        initUserDefaults()
        
        setupAppearance()
    }
    
    private class func initServices(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
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
    
    private class func initLogger() {
        let systemDestination = AppleSystemLogDestination(identifier: "mainLogger.systemDestination")
        
        systemDestination.outputLevel = .debug
        systemDestination.showLogIdentifier = false
        systemDestination.showFunctionName = true
        systemDestination.showThreadName = true
        systemDestination.showLevel = true
        systemDestination.showFileName = true
        systemDestination.showLineNumber = true
        systemDestination.showDate = true
        
        logger.add(destination: systemDestination)
        
        let cachePath = FileManager.default.urls(for: .cachesDirectory,
                                                 in: .userDomainMask)[0]
        let logURL = cachePath.appendingPathComponent("log.txt")
        let fileDestination = FileDestination(writeToFile: logURL, identifier: "mainLogger.fileDestination")
        
        fileDestination.outputLevel = .debug
        fileDestination.showLogIdentifier = false
        fileDestination.showFunctionName = true
        fileDestination.showThreadName = true
        fileDestination.showLevel = true
        fileDestination.showFileName = true
        fileDestination.showLineNumber = true
        fileDestination.showDate = true
        
        fileDestination.logQueue = XCGLogger.logQueue
        
        logger.add(destination: fileDestination)
        
        logger.logAppDetails()

    }
    
    private class func initPersistentData() {
        
    }
    
    private class func initUserDefaults() {
        
    }
    
    private class func setupAppearance() {
        UINavigationBar.appearance().tintColor = UIColor(hex: 0x3E2D1F)
        UINavigationBar.appearance().barTintColor = UIColor(hex: 0xCAB77D)
        UINavigationBar.appearance().isTranslucent = false
    }
    
}

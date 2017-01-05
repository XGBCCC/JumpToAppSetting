//
//  AppDelegate.swift
//  JumpToAppSetting
//
//  Created by JimBo on 2017/1/2.
//  Copyright © 2017年 JimBo. All rights reserved.
//

import UIKit
import CoreSpotlight

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if userActivity.activityType == CSSearchableItemActionType {
            if let identifier = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String {
                
                //获取到相应app，并进行跳转
                if let app = JSAppListCache.cache.appNameDict[identifier]?.2 {
                    REHelper.openApplicationSetting(app)
                }
                
                return true
            }
        }
        return true
    }

}


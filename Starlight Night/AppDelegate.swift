//
//  AppDelegate.swift
//  Starlight Night
//
//  Created by Alexey on 1/26/20.
//  Copyright © 2020 it-Business-Partner. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import AppsFlyerLib

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppsFlyerTrackerDelegate {
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {

    }

    func onConversionDataFail(_ error: Error) {

    }


    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Chartboost.start(withAppId: "5e300f42e52a120b35998b88", appSignature: "26b128a35e178b4e1d06cec69e47bf8841ba3b7a", delegate: nil)
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(
              application,
              didFinishLaunchingWithOptions: launchOptions
          )
        AppLinkUtility.fetchDeferredAppLink { (url, error) in
                   if let error = error {
                       print("Received error while fetching deferred app link %@", error)
                   }
                   if let url = url {
                       if #available(iOS 11, *) {
                           UIApplication.shared.open(url, options: [:], completionHandler: nil)
                       } else {
                           UIApplication.shared.openURL(url)
                       }
                   }
               }
        if UserDefaults.standard.value(forKey: "AppsFlyerDevKey") != nil &&  UserDefaults.standard.value(forKey: "AppsFlyerID") != nil{
        AppsFlyerTracker.shared().appsFlyerDevKey = String(UserDefaults.standard.value(forKey: "AppsFlyerDevKey") as! String)
        AppsFlyerTracker.shared().appleAppID = String(UserDefaults.standard.value(forKey: "AppsFlyerID") as! String)
        }

             AppsFlyerTracker.shared().delegate = self
               return true;
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEvents.activateApp()
        AppsFlyerTracker.shared().trackAppLaunch()
    }
}


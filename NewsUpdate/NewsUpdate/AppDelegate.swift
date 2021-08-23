//
//  AppDelegate.swift
//  NewsUpdate
//
//  Created by Adrian Suryo Abiyoga on 22/08/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let liveNews = LiveNewsRouter.createModule()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = liveNews
        window?.makeKeyAndVisible()
        
        return true
    }
}

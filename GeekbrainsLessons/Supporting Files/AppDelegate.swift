//
//  AppDelegate.swift
//  GeekbrainsLessons
//
//  Created by Oleg Bochkarev on 02/03/2019.
//  Copyright © 2019 oleg.bochkarev. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityLogger
import AlamofireNetworkActivityIndicator
import SwiftKeychainWrapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        defaultSetups()
        startApp()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - DEFAULT SETUPS
    
    private func defaultSetups() {
        NetworkActivityIndicatorManager.shared.isEnabled = true
        NetworkActivityIndicatorManager.shared.startDelay = 0
        NetworkActivityIndicatorManager.shared.completionDelay = 0.2
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
    }
    
    private func startApp() {
        let storyboardName: String
        if userAuthorized() {
            storyboardName = "Main"
        } else {
            storyboardName = "Authorization"
        }
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.makeKeyAndVisible()
        window!.rootViewController = storyboard.instantiateInitialViewController()
    }
    
    func userAuthorized() -> Bool {
        //это лишь пример. В реальности, конечно, здесь все может быть сложнее, и хранить токен в UserDefaults не стоит
        if let token = KeychainWrapper.standard.string(forKey: GlobalConstants.KeychainKey.token),
            let userId = UserDefaults.standard.value(forKey: GlobalConstants.UserDefaultsKey.userId) as? Int {
            Session.shared.token = token
            Session.shared.userId = userId
            print("saved token = \(token)")
            print("saved userId = \(userId)")
            return true
        } else {
            return false
        }
    }
    
}


//
//  AppDelegate.swift
//  Mall
//
//  Created by midland on 2019/7/15.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let mainViewController = MainTabBarController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        logger.debug("一条verbose级别消息：程序执行时最详细的信息。")
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        setupRootViewController()
        self.window?.makeKeyAndVisible()
        
        Log.info("msg")
        
        /*
        // 重要：只支持模拟器 https://blog.csdn.net/yanglei3kyou/article/details/90603961
        #if DEBUG
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
        //Or for macOS:
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/macOSInjection.bundle")?.load()
        #endif
         */
        
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
    
    func setupRootViewController() {
        mainViewController.setupRootVC()
    }
    
    public func restoreRootViewController(newRootVC: UIViewController) {
        guard let window = window else {
            return
        }
        window.rootViewController = newRootVC
    }

}


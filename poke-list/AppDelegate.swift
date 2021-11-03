//
//  AppDelegate.swift
//  poke-list
//
//  Created by Nicola Innocenti on 30/10/21.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureStyles()
        
        let _ = try! Realm()
        
        if #available(iOS 13.0, *) {
            
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            if let lastSync = UIApplication.shared.lastSync, lastSync > 0 {
                window?.rootViewController = TabBarViewController()
            } else {
                window?.rootViewController = SplashViewController()
            }
            window?.makeKeyAndVisible()
        }
        
        return true
    }
    
    func configureStyles() {
        if #available(iOS 13.0, *) {
            let navAppearance = UINavigationBarAppearance()
            navAppearance.configureWithOpaqueBackground()
            navAppearance.backgroundColor = .navBar
            navAppearance.titleTextAttributes = [
                .foregroundColor: UIColor.navBarTint as Any,
                .font: UIFont.semiBold(size: 17) as Any
            ]
            UINavigationBar.appearance().standardAppearance = navAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
            
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = .tabBar
            tabBarAppearance.selectionIndicatorTintColor = .tabBarTint
            UITabBar.appearance().standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        } else {
            UINavigationBar.appearance().barTintColor = .navBar
            UINavigationBar.appearance().tintColor = .navBarTint
            UINavigationBar.appearance().titleTextAttributes = [
                .foregroundColor: UIColor.navBarTint as Any,
                .font: UIFont.semiBold(size: 17) as Any
            ]
            
            UITabBar.appearance().barTintColor = .tabBar
            UITabBar.appearance().tintColor = .tabBarTint
        }
    }

    // MARK: UISceneSession Lifecycle

    @available (iOS 13, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available (iOS 13, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}


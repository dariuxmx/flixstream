//
//  AppDelegate.swift
//  FlixStream
//
//  Created by Edwin Dario Gutierrez Pech on 7/27/20.
//  Copyright © 2020 Habanero Studio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ConfigVariables.shared.readConfigFile()
        self.customInitUI()
        
        return true
    }
    
    func customInitUI (){
        //Custom UI
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .white
        
        //Custom Font
        let attributes = [
            NSAttributedString.Key.font: UIFont (name: "Airbnb Cereal App", size: 22)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
            ] as [NSAttributedString.Key : Any]

        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.titleTextAttributes = attributes
        navigationBarAppearace.tintColor = .white
//        navigationBarAppearace.barTintColor = #colorLiteral(red: 0.2440274656, green: 0.6904171109, blue: 0.08412704617, alpha: 1)
//        navigationBarAppearace.isTranslucent = false
        
        navigationBarAppearace.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBarAppearace.shadowImage = UIImage()
        navigationBarAppearace.isTranslucent = true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


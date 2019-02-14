//
//  AppDelegate.swift
//  Drahtesel
//
//  Created by Mathias Roder on 03.02.19.
//  Copyright © 2019 Radler. All rights reserved.
//

import UIKit
import CoreData
import ReSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?
   var appStore: Store<AppState>!

   // TODO: move to separate file
   let FactoryContetVersionKey = "FactoryContentVersion"
   var factoryContentVersion: Int {
      get { return UserDefaults.standard.integer(forKey: FactoryContetVersionKey) }
      set { UserDefaults.standard.set(newValue, forKey: FactoryContetVersionKey) }
   }

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
   {
      let content = FactoryContent()
      if content.version > factoryContentVersion {
         factoryContentVersion = content.version
         print("Create Factory Content")
         content.create()
      }
      
      appStore = Store<AppState>(reducer: AppState.reducer, state: nil, middleware: [loggingMiddleware])
      
      return true
   }

   func applicationWillResignActive(_ application: UIApplication) {
      // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
      // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
   }

   func applicationDidEnterBackground(_ application: UIApplication) {
      DBAccess.shared.save()
   }

   func applicationWillEnterForeground(_ application: UIApplication) {
      // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
   }

   func applicationDidBecomeActive(_ application: UIApplication) {
      // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   }

   func applicationWillTerminate(_ application: UIApplication) {
      DBAccess.shared.save()
   }
}

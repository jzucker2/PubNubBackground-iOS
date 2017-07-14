//
//  AppDelegate.swift
//  PubNubBackground
//
//  Created by Jordan Zucker on 7/14/17.
//  Copyright © 2017 PubNub. All rights reserved.
//

import UIKit
import PubNub

let publishKey = "pub-c-079833e8-02a8-48f9-b24b-c940f97c659c"
let subscribeKey = "sub-c-a21a0184-68df-11e7-898a-02ee2ddab7fe"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var client: PubNub?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let config = PNConfiguration(publishKey: publishKey, subscribeKey: subscribeKey)
        config.stripMobilePayload = false
        config.presenceHeartbeatInterval = 10
        config.presenceHeartbeatValue = 20
        config.heartbeatNotificationOptions = [.notifyAll]
        self.client = PubNub.clientWithConfiguration(config)
        client?.addListener(self)
        client?.subscribeToChannels(["a"], withPresence: true)
        LocationService.shared.startUpActions()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print("\(#function)")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("\(#function)")
        // MARK: - Edit here
        // If you comment this line out, heartbeats will not continue in the background.
        self.client?.unsubscribeFromAll()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("\(#function)")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("\(#function)")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("\(#function)")
    }


}

extension AppDelegate: PNObjectEventListener {
    
    func client(_ client: PubNub, didReceive status: PNStatus) {
        print("\(#function) status: \(status.debugDescription)")
    }
    
    func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
        print("\(#function) message: \(message.debugDescription)")
    }
    
}




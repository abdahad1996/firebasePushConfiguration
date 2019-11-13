//
//  AppDelegate.swift
//  pushNotification
//
//  Created by engitech on 11/11/2019.
//  Copyright © 2019 engitech. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let pushManager = PushNotificationManager(userID: "currently_logged_in_user_id")
        pushManager.registerForPushNotifications()
        let navController = UINavigationController(rootViewController: ViewController())
         window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true


}


}
//        // Override point for customization after application launch.
//        print("gello ")
//        //when app starts
////        you request authorization from the user to send badges, sounds and alerts to the user. If any of those items are granted by the user, you register the app for notifications.”
////umusermotificaiton runs on bg thread so we register for remote notification on main thread
//
////        If you include .provisional in the options argument, notifications will automatically be delivered silently to the user’s Notification Center, without asking for permission – there will be no sound or alerts for these provisional notifications. users can see in notifcaiton centre these notifications and can authorize them fromt there .
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options: [
//            .badge, .sound, .alert
//            ])
//        {
//        // 1
//                [weak self] granted, _ in
//
//                // 2
//                guard granted else {
//                  return
//                }
//
//                // 3
//                center.delegate = self
//
//
//              DispatchQueue.main.async {
//                application.registerForRemoteNotifications()
//              }
//            }
//
//        return true
//    }
//
//
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//      let token = deviceToken.reduce("") { $0 + String(format: "%02x", $1) }
//      print(token)
//    }
//
//
//}
////normally notification is shown only in background but using willprsent method of usernotification delegate we can show them in foreground. we set the delegate to be appdelegate at didfinish launching method
//extension AppDelegate: UNUserNotificationCenterDelegate {
//  func userNotificationCenter(
//    _ center: UNUserNotificationCenter,
//    willPresent notification: UNNotification,
//    withCompletionHandler completionHandler:
//    @escaping (UNNotificationPresentationOptions) -> Void) {
//
//    completionHandler([.alert, .sound, .badge])
//  }
//}
//

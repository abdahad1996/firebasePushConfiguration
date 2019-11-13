//
//  PushNotifictionManager.swift
//  pushNotification
//
//  Created by engitech on 13/11/2019.
//  Copyright © 2019 engitech. All rights reserved.
//

import Firebase
import FirebaseFirestore
import FirebaseMessaging
import UIKit
import UserNotifications

class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {
    let userID: String
    init(userID: String) {
        self.userID = userID
        super.init()
    }

    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }

        UIApplication.shared.registerForRemoteNotifications()
        updateFirestorePushTokenIfNeeded()
    }

    func updateFirestorePushTokenIfNeeded() {
        if let token = Messaging.messaging().fcmToken {
//            let usersRef = Firestore.firestore().collection("users_table").document(userID)
//            usersRef.setData(["fcmToken": token], merge: true)
//        }
            print("fcm token \(token)")
            
        }
    }
//    Handle data messages received via FCM direct channel (not via APNS).
//    does not get called when we tapped. its not related to apns
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {                print("renotemessge")
        print(remoteMessage.appData) // or do whatever
    }

    //    This method will be called once a token is available, or has been refreshed. Typically it will be called once per app start, but may be called more often, if token is invalidated or updated. In this method, you should perform operations such as
//    The registration token may change when:
//    The app is restored on a new device
//    The user uninstalls/reinstall the app
//    The user clears app data.
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("fcm token1 \(fcmToken)")
        updateFirestorePushTokenIfNeeded()
    }

    //for user interaction such as tapping
    //called in foreground and background. this is used for handling notificaiton tapping or custom action
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        At the end of your implementation, call the completionHandler block to let the system know that you are done processing the user's response. If you do not implement this method, your app never responds to custom action
      defer { completionHandler() }

      // response is An action that indicates the user opened the app from the notification interface.
      guard response.actionIdentifier == UNNotificationDefaultActionIdentifier else {
        return
      }
        print(response  )
        let payload = response.notification.request.content.userInfo
        print("jhdfsfhfshvsfshfhsvhfsvfhshvsvsfsf")
        print(payload)
        //deep linking done here
      guard let value = payload["beach"] else { return }
        print("value is ")

        print(value)

        let navController = UINavigationController(rootViewController: VC2())
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
              appDelegate.window!.rootViewController  = navController
//      let storyboard = UIStoryboard(name: "Main", bundle: nil)
//      let vc = storyboard.instantiateViewController(withIdentifier: "beach")
//
//      let appDelegate = UIApplication.shared.delegate as! AppDelegate
//      appDelegate.window!.rootViewController!.present(vc, animated: false)
    }
    
    //if method swizling den we set apns token manually 
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    //to show notifiction in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      completionHandler([.alert, .sound, .badge])
    }}

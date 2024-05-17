//
//  AppDelegate+Firebase.swift
//  App
//
//  Created by gnksbm on 3/21/24.
//  Copyright © 2024 Pepsi-Club. All rights reserved.
//

import UIKit

import Firebase
import FirebaseMessaging

extension AppDelegate {
    func configureFirebase(application: UIApplication) {
        var googleInfoName: String
        #if DEBUG
        googleInfoName = "GoogleService-Info-debugging"
        #else
        googleInfoName = "GoogleService-Info"
        #endif
        guard let filePath = Bundle.main.path(
            forResource: googleInfoName,
            ofType: "plist"
        ),
            let options = FirebaseOptions(contentsOfFile: filePath)
            else { return }
        FirebaseApp.configure(options: options)
        application.registerForRemoteNotifications()
    }
}

extension AppDelegate {
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().delegate = self
        Messaging.messaging().apnsToken = deviceToken
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        guard let fcmToken else { return }
        UserDefaults.standard.setValue(
            fcmToken,
            forKey: "fcmToken"
        )
    }
}

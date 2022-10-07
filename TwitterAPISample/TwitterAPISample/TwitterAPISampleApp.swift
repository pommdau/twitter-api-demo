//
//  TwitterAPISampleApp.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/05.
//

import SwiftUI

@main
struct TwitterAPISampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { callbackUrl in
                    NotificationCenter.default.post(name: Notification.Name.receivedCallBackURL,
                                                    object: nil,
                                                    userInfo: [NotificationUserinfoKeys.callbackURL: callbackUrl])
                }
        }
    }
}

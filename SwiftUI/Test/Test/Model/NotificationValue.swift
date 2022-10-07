//
//  NotificationValue.swift
//  Test
//
//  Created by Ivan Pryhara on 18.09.22.
//

import Foundation
import UserNotifications

//MARK: Model holds all Notification Data

struct NotificationValue: Identifiable {
    var id: String = UUID().uuidString
    var content: UNNotificationContent
    var dateCreated: Date = Date()
    var showNotification: Bool = false
}

//
//  NotifyManager.swift
//  PetNote
//
//  Created by iching chen on 2019/9/30.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import UserNotifications

class NotifyManager {
//    let center = UNUserNotificationCenter.current()
    static let shared = NotifyManager()
    
    private init() {}
    
    func createNotification(by notificationObjet: NotificationObject, with identifier: String? = nil, completion: @escaping (Result<(String, NotificationObject), Error>) -> Void) {
        // 查看是否有通知 identifer，若有則刪除之前通知
        if let identifier = identifier {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
            UNUserNotificationCenter.current().getPendingNotificationRequests { notifyArray in
                
                notifyArray.forEach {
                    print($0.identifier)
                }
            }
        }
        
        // 通知為關閉狀態，不創建新通知
        if !notificationObjet.isSwitchOn {
            completion(Result.success(("", notificationObjet)))
            return
        }
        
        // 創立通知
        let content = UNMutableNotificationContent()
        content.title = notificationObjet.alertText
        content.sound = UNNotificationSound.default
        
        // 結合日期和時間字串再重新轉成 date，format 格式為 yyyy 年 MM 月 dd 日 HH:mm
        let dateString = "\(notificationObjet.nextDate.getDateString()) \(notificationObjet.alertTime.getDateString(format: "HH:mm"))"
        let timeformat = DateFormatter.init()
        timeformat.dateFormat = "yyyy 年 MM 月 dd 日 HH:mm"
        
        guard
            let date = timeformat.date(from: dateString)
        else {
            completion(Result.failure(NotificationError.timeTransformError))
            return
        }
        let calendar = Calendar.current
        
        guard
            let frequencyType = RepeatType.init(rawValue: notificationObjet.frequencyTypes)
        else {
            completion(Result.failure(NotificationError.invalidRepeatType))
            return
        }
        
        let components = calendar.dateComponents(
            frequencyType.componentSet,
            from: date
        )
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: frequencyType.isRepeat
        )
        
        let dateIdentifier = "\(Int(Date().timeIntervalSince1970))"
        
        let request = UNNotificationRequest(
            identifier: dateIdentifier,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(
            request,
            withCompletionHandler: { error in
                guard
                    let error = error
                else {
                    completion(Result.success((dateIdentifier, notificationObjet)))
                    return
                }
                completion(Result.failure(error))
        })
    }
   
}

enum NotificationError: Error {
    case timeTransformError
    case invalidRepeatType
    case addNotificationError
}

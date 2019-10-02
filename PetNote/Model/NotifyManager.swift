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
        
        print("要刪除的 identifier 為: \(identifier)")
        if let identifier = identifier {
//            UNUserNotificationCenter.current().removeDeliveredNotifications(
//                withIdentifiers: [identifier])
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
            UNUserNotificationCenter.current().getPendingNotificationRequests { notifyArray in
                print("======目前的推播列表共 \(notifyArray.count) 筆資料， id 如下：")
                notifyArray.forEach {
                    print($0.identifier)
                }
            }
        }
        
        if !notificationObjet.isSwitchOn {
            print("通知為關閉狀態，不創建新通知")
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
                print("日期轉換失敗，推播設定失敗")
                completion(Result.failure(NotificationError.timeTransformError))
                return
        }
        let calendar = Calendar.current
        
        guard
            let frequencyType = RepeatType.init(rawValue: notificationObjet.frequencyTypes)
        else {
            print(notificationObjet.frequencyTypes)
            print("無法辨識的 RepeatType")
            completion(Result.failure(NotificationError.invalidRepeatType))
            return
        }
        
        let components = calendar.dateComponents(
            frequencyType.componentSet,
            from: date)
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: frequencyType.isRepeat)
        
        let dateIdentifier = "\(Int(Date().timeIntervalSince1970))"
        print("新建立的推播 id 為\(dateIdentifier)")
        
        let request = UNNotificationRequest(
            identifier: dateIdentifier,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(
            request,
            withCompletionHandler: { error in
                guard
                    let error = error
                else {
                    print("推波建立成功，新建立的推播 id 為\(dateIdentifier)")
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

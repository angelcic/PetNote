//
//  AppDelegate.swift
//  PetNote
//
//  Created by iching chen on 2019/8/29.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("=========")
        print(NSPersistentContainer.defaultDirectoryURL()) // 取得 SQlite 路徑
        // 開啟 App 先從 DB 讀取使用者先前放入購物車的資料
//        if let orders = StorageManager.manager.fetchPetsList() {
//            StorageManager.manager.orderList += orders
//        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        StorageManager.shared.saveAll()
    }
}

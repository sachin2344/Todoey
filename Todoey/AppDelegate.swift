//
//  AppDelegate.swift
//  Todoey
//
//  Created by sachin sharma on 09/05/19.
//  Copyright © 2019 sachin sharma. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//      print(Realm.Configuration.defaultConfiguration.fileURL)
       
//        let data = Data()
//        data.name = "Sachin"
//        data.age = 24
        
        do{
            let realm = try Realm()
//            try realm.write {
//                realm.add(data)
//            }
        }catch{
            print("Error initializing new realm,\(error)")
        }
        
        return true
    }


}


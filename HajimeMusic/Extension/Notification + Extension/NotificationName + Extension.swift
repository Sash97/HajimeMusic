//
//  NotificationName + Extension.swift
//  Evenation
//
//  Created by Aleksandr Bagdasaryan on 11/22/19.
//  Copyright © 2019 Aleksandr Bagdasaryan. All rights reserved.
//

import Foundation


extension Notification.Name {
    static let sideBarButtonTapped = Notification.Name("sideBarButtonTapped")
    static let tabBarWillHide      = Notification.Name("tabBarWillHide")
    static let tabBarWillShow      = Notification.Name("tabBarWillShow")
    static let orderButtonWillShow = Notification.Name("orderButtonWillShowNotification")
}


extension NSObject {
    func observeNotification(name: Notification.Name, selector: Selector?) {
        if let selector = selector {
            NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
        } else {
            NotificationCenter.default.removeObserver(self, name: name, object: nil)
        }
    }
    
    func postNotification(name: Notification.Name, object: AnyObject? = nil) {
        if let dict = object as? NSDictionary {
            NotificationCenter.default.post(name: name, object: nil, userInfo: dict as [NSObject: AnyObject])
        } else if let object: AnyObject = object {
            NotificationCenter.default.post(name: name, object: nil, userInfo: ["object": object])
        } else {
            NotificationCenter.default.post(name: name, object: nil, userInfo: nil)
        }
    }
}

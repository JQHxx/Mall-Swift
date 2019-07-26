//
//  BFBarista.swift
//  Mall
//
//  Created by midland on 2019/7/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import UIKit

// 利用协议优化通知
protocol Notifier {
    // 添加一个关联的类型
    associatedtype Notification: RawRepresentable
}

extension Notifier where Notification.RawValue == String {
    
    static func nameFor(notification: Notification) -> String {
        
        return "\(notification.rawValue)"
    }
}

class  BFBarista: Notifier {
    
    /// 发送通知
    static func post(notification: Notification, object:AnyObject? = nil) {
        
        let name = nameFor(notification: notification)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: object)
    }
    
    /// 增加观察 - 接收通知
    static func add(observer: AnyObject, selector: Selector, notification: Notification, object:AnyObject? = nil) {
        
        let name = nameFor(notification: notification)
        NotificationCenter.default
            .addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name), object: object)
    }
    
    /// 移除观察 - 移除通知
    static func remove(observer: AnyObject, notification: Notification, object:AnyObject? = nil) {
        
        let name = nameFor(notification: notification)
        NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(rawValue: name), object: object)
    }
}

// 定义的通知名字
extension  BFBarista {
    enum Notification: String {
        case login
    }
}

/*
 * 添加: Barista.add(observer: self, selector: #selector(reload), notification: .happy)
 * 移除: Barista.remove(observer: self, notification: .happy)
 * 发出通知: Barista.post(notification: .happy)
 */

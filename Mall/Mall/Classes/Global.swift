//
//  Global.swift
//  Mall
//
//  Created by midland on 2019/7/18.
//  Copyright © 2019 JQHxx. All rights reserved.
//

@_exported import Foundation
@_exported import UIKit
@_exported import Kingfisher
@_exported import SwiftyJSON
@_exported import Alamofire
@_exported import SnapKit

// MARK: - 常量
// 导航栏(动态获取主要为了适配iphone X)
let kNavigationBarH : CGFloat = 44.0
let kTabBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height > 20 ? 83 : 49
let kStatusBarH : CGFloat = UIApplication.shared.statusBarFrame.size.height

// MARK: - 主线程上刷新UI
func dispatch_sync_safely_main_queue(_ block: ()->()) {
    if Thread.isMainThread {
        block()
    } else {
        DispatchQueue.main.sync {
            block()
        }
    }
}

// 延迟调用
func dispatch_delay(time: TimeInterval, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: {
        closure()
    })
}

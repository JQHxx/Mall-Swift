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

/// MARK: - 常量
// 导航栏(动态获取主要为了适配iphone X)
var kStatusHeight: CGFloat {
    return UIApplication.shared.statusBarFrame.size.height
}

var kNavBarHeight: CGFloat {
    return 44.0
}

/// 固定的分页大小
var pageSizeFixed: Int {
    return 20
}

/// MARK: - 主线程上刷新UI
func dispatch_sync_safely_main_queue(_ block: ()->()) {
    if Thread.isMainThread {
        block()
    } else {
        DispatchQueue.main.sync {
            block()
        }
    }
}

/// 延时调用
func dispatch_delay(time: TimeInterval, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: {
        closure()
    })
}

/// 类实例方法交换
///
/// - Parameters:
///   - cls: 类名
///   - targetSel: 目标方法
///   - newSel: 替换方法
@discardableResult
func exchangeMethod(cls: AnyClass?, targetSel: Selector, newSel: Selector) -> Bool {
    
    guard let before: Method = class_getInstanceMethod(cls, targetSel),
        let after: Method = class_getInstanceMethod(cls, newSel) else {
            return false
    }
    method_exchangeImplementations(before, after)
    return true
}

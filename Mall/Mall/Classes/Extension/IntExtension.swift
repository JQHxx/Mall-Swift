//
//  IntExtension.swift
//  Mall
//
//  Created by midland on 2019/8/23.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    
    /// 数量超过1万以后显示的内容
    public var countString: String {
        return self / 10000 >= 1 ? "\(self / 10000)万" : "\(self)"
    }
    
    /// 视频时长
    public var timeDuration: String {
        
        let minute = self / 60
        let hour = minute / 60
        let second = String(format: "%02d", self % 60)
        
        if minute < 60 { // 视频时长小于一小时
            return "\(String(format: "%02d", minute)):\(second)"
        } else { // 视频时长超过一小时
            return "\(String(format: "%02d", hour)):\(String(format: "%02d", minute)):\(second)"
        }
    }
}

//
//  DispatchQueueExtension.swift
//  Mall
//
//  Created by midland on 2019/8/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation

typealias Task = (_ cancel: Bool) -> Void

extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    public class func once(_ token: String, _ block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
}

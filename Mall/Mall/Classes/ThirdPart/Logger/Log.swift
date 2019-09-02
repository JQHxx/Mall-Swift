//
//  Log.swift
//  Mall
//
//  Created by midland on 2019/8/29.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation



struct Log {
    
    static let infoDictionary = Bundle.main.infoDictionary ?? [:]
    static let appName = infoDictionary["CFBundleDisplayName"] //程序名称
    
    private static func _log<T>(_ title: String, _ msg: T, _ file: NSString,
                                _ fn: String, _ line: Int) {
        #if DEBUG
        print("「 \(appName ?? "") 」\(title) \(file.lastPathComponent) \(line)行 >> \(fn) => \(msg) \(title)")
        #endif
    }
    
    static func error<T>(_ msg: T,
                         _ file: NSString = #file,
                         _ fn: String = #function,
                         _ line: Int = #line) {
        _log("❌", msg, file, fn, line)
    }
    
    static func warnning<T>(_ msg: T,
                            _ file: NSString = #file,
                            _ fn: String = #function,
                            _ line: Int = #line) {
        _log("⚠️", msg, file, fn, line)
    }
    
    static func success<T>(_ msg: T,
                           _ file: NSString = #file,
                           _ fn: String = #function,
                           _ line: Int = #line) {
        _log("✔️", msg, file, fn, line)
    }
    
    static func info<T>(_ msg: T,
                        _ file: NSString = #file,
                        _ fn: String = #function,
                        _ line: Int = #line) {
        _log("🗯", msg, file, fn, line)
    }
    
    static func debug<T>(_ msg: T,
                        _ file: NSString = #file,
                        _ fn: String = #function,
                        _ line: Int = #line) {
        _log("🔹", msg, file, fn, line)
    }
}

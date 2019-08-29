//
//  Logger.swift
//  Mall
//
//  Created by midland on 2019/8/23.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import XCGLogger

let logger = Logger.sharedInstance

fileprivate class Logger: XCGLogger {
    
    private static var xcgLogger: XCGLogger? = nil
    
    private init(){}
    
    static var sharedInstance: XCGLogger = {
        struct Statics {
            static let log = Logger.xcgLogger == nil ? setup() : Logger.xcgLogger
        }
        return Statics.log!
    }()
    
    private static func setup() -> XCGLogger {
        let log = XCGLogger.default
        #if DEBUG // Set via Build Settings, under Other Swift Flags
        log.setup(level: .debug, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true)
        #else
        log.setup(level: .severe, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true)
        #endif
        let emojiLogFormatter = PrePostFixLogFormatter()
        emojiLogFormatter.apply(prefix: "🗯 ", postfix: " 🗯", to: .verbose)
        emojiLogFormatter.apply(prefix: "🔹 ", postfix: " 🔹", to: .debug)
        emojiLogFormatter.apply(prefix: "ℹ️ ", postfix: " ℹ️", to: .info)
        emojiLogFormatter.apply(prefix: "⚠️ ", postfix: " ⚠️", to: .warning)
        emojiLogFormatter.apply(prefix: "‼️ ", postfix: " ‼️", to: .error)
        emojiLogFormatter.apply(prefix: "💣 ", postfix: " 💣", to: .severe)
        log.formatters = [emojiLogFormatter]
        
        return log
    }
    
}

/*
 logger.verbose("一条verbose级别消息：程序执行时最详细的信息。")
 logger.debug("一条debug级别消息：用于代码调试。")
 logger.info("一条info级别消息：常用与用户在console.app中查看。")
 logger.warning("一条warning级别消息：警告消息，表示一个可能的错误。")
 logger.error("一条error级别消息：表示产生了一个可恢复的错误，用于告知发生了什么事情。")
 logger.severe("一条severe error级别消息：表示产生了一个严重错误。程序可能很快会奔溃。")
 */

//
//  AppKeyChain.swift
//  Mall
//
//  Created by midland on 2019/7/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import KeychainSwift

/**
 * keychain保存敏感信息
 */
class AppKeyChain {
    
    static func setToken(token: String) {
        let keychain = KeychainSwift()
        keychain.accessGroup = "com.my.Mall"
        keychain.set(token, forKey: "com.my.Mall.token")
    }
    
    static func getToken() -> String {
        let keychain = KeychainSwift()
        keychain.accessGroup = "com.my.Mall"
        return keychain.get("com.my.Mall.token") ?? ""
    }
    
    static func clearToken() {
        let keychain = KeychainSwift()
        keychain.accessGroup = "com.my.Mall"
        keychain.delete("com.my.Mall.token")
    }
    
    static func clearAll() {
        let keychain = KeychainSwift()
        keychain.accessGroup = "com.my.Mall"
        keychain.clear()
    }
    
}

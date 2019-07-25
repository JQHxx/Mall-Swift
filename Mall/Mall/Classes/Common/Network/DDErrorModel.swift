//
//  DDErrorModel.swift
//  Mall
//
//  Created by midland on 2019/7/25.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation

class DDErrorModel {
    
    var status: Int = 0
    var message: String = ""
    
    init(status: Int, message: String) {
        self.status = status
        self.message = message
    }
}

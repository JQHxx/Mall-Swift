//
//  DDRequestModel.swift
//  Mall
//
//  Created by midland on 2019/7/25.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import SwiftyJSON

class IRequestModel {
    
    var code: Int = 0
    var message: String = ""
    // true为请求成功
    var result: Bool = false
    
    init(jsonData: JSON) {
        
        code = jsonData["code"].intValue
        message = jsonData["msg"].stringValue
        result = jsonData["result"].boolValue
    }
}

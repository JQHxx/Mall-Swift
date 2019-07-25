//
//  DDHTTPRequest.swift
//  Mall
//
//  Created by midland on 2019/7/25.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import SwiftyJSON

class DDHTTPRequest {
    
    // 基本的网络请求
    class func request<T: BFRequest>(r: T, requestSuccess: @escaping RequestSucceed, requestError: @escaping RequestError, requestFailure: @escaping RequestFailure) {
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        HTTPClient.shared.send(r, success: { (result) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            debugPrint("result====>\(String.init(describing: result).removingPercentEncoding ?? "")")
            interceptResponse(r: r, response: result, requestSuccess: requestSuccess, requestError: requestError, requestFailure: requestFailure)
        }, failure: { (error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            debugPrint("error====>" + "\(error)")
            requestFailure(error)
            if r.isCheckNetStatus {
                check(netWork: error)
            }
        }) { (response, errorModel) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            requestError(response, errorModel)
        }
        
    }
    
    // 图片上传网络请求
    class func upLoadfiles<T: BFRequest>(r: T, requestSuccess: @escaping RequestSucceed, requestError: @escaping RequestError, requestFailure: @escaping RequestFailure) {
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        HTTPClient.shared.upload(r, success: { (result) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            debugPrint("result====>\(String.init(describing: result).removingPercentEncoding ?? "")")
            interceptResponse(r: r, response: result, requestSuccess: requestSuccess, requestError: requestError, requestFailure: requestFailure)
            
        }, failure: { (error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            requestFailure(error)
            if r.isCheckNetStatus {
                check(netWork: error)
            }
        }) { (response, errorModel) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            requestError(response, errorModel)
        }
        
    }
    
}

extension DDHTTPRequest {
    
    // 处理数据
    fileprivate class func interceptResponse<T: BFRequest>(r: T, response: [String: AnyObject], requestSuccess: @escaping RequestSucceed, requestError: @escaping RequestError, requestFailure: @escaping RequestFailure) {
        let object = DDRequestModel(jsonData: JSON(response))
        let status = object.code
        let msg = object.message
        let result = object.result
        
        switch status {
        case 401: // Token 过期
            BFunction.shared.hideLoadingMessage()
            let m = DDErrorModel(status: status, message: msg)
            requestError(response, m)
            break
        case 200: // 请求成功
            if result {
                requestSuccess(response)
            } else {
                let m = DDErrorModel(status: 999999, message: msg)
                requestError(response, m)
            }
            break
            
        default:
            let m = DDErrorModel(status: status, message: msg)
            requestError(response, m)
            break
        }
        
    }
}

extension DDHTTPRequest {
    /// 检查网络错误状态
    ///
    /// - Parameter error: Error
    class func check(netWork error: Error) {
        debugPrint("错误码 ===》" + "\(error._code)" + "错误描述 ===》" + error.localizedDescription)
        
        switch error._code {
        case -1009: BFunction.shared.showErrorMessage("似乎已和网络断开了连接")
        case -1004: BFunction.shared.showErrorMessage("与服务器断开连接")
        case -999 : debugPrint("服务器主动断开网络请求")
        case -1001: BFunction.shared.showErrorMessage("请求超时")
        case -1011: BFunction.shared.showErrorMessage("攻城狮正在抢修服务器...")
        default   : BFunction.shared.showErrorMessage("您的网络好像有点问题")
        }
    }
}

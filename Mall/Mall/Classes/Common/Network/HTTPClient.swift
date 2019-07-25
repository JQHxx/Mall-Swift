//
//  HTTPClient.swift
//  Mall
//
//  Created by midland on 2019/7/25.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import Alamofire

/// 请求成功
typealias RequestSucceed = (_ result: [String: AnyObject]) -> ()
/// 请求失败
typealias RequestFailure = (_ error: Error) -> ()
/// 请求错误回调
typealias RequestError   = (_ result: [String: AnyObject], _ errorObject: DDErrorModel) -> ()

public enum ZHFHTTPMethod: Int {
    case POST = 0
    case GET
}

// MARK: - 协议
public protocol BFRequest {
    // 接口
    var path: String { get }
    // 请求方式
    var method: ZHFHTTPMethod { get }
    // 请求参数
    var parameters: [String: Any]? { get }
    // 是否显示指示器
    var hud: Bool { get }
    // 自定义请求头
    var normalHeaders: [String: String] { get }
    // 文件上传的请求头
    var uploadHeaders: [String: String] { get }
    // 服务器的基本地址
    var host: String { get }
    // 是否检查网络状态
    var isCheckNetStatus: Bool { get }
    // 是否检查请求错误
    var isCheckRequestError: Bool { get }
}

// MARK: - 协议默认实现
extension BFRequest {
    
    var hud: Bool {
        return false
    }
    
    var method: ZHFHTTPMethod {
        return ZHFHTTPMethod.POST
    }
    
    // 服务器的基本地址
    var host: String {
        return API.baseServer
    }
    
    // 是否检查网络状态
    var isCheckNetStatus: Bool {
        return true
    }
    
    // 是否检查请求错误
    var isCheckRequestError: Bool {
        return true
    }
    
    var normalHeaders: [String: String] {
        // 2.自定义头部
        let token = ""
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "token": token
        ]
        return headers
    }
    
    var uploadHeaders: [String: String] {
        // 2.自定义头部
        let token = ""
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "content-type": "multipart/form-data",
            "token": token
        ]
        return headers
    }
    
    var parameters: [String: Any]? {
        var param = [String: Any]()
        let mirror = Mirror(reflecting: self)
        
        for case let (label?, value) in mirror.children {
            param[label] = value
        }
        //let token = AppKeyChain.getToken() ?? ""
        //param["token"] = token
        return param
    }
    
}

// MARK: - 网络请求相关
class HTTPClient {
    
    // 创建单例
    static let shared = HTTPClient()
    private init() {}
    
    // 普通的网络请求
    func send<T: BFRequest>(_ r: T, success: @escaping RequestSucceed, failure: @escaping RequestFailure, requestError: @escaping RequestError) {
        
        debugPrint("请求链接:\(r.host + r.path)")
        debugPrint("请求参数:\( r.parameters ?? [:] )")
        
        let httpMethod = getMethod(type: r.method)
        sessionManager.session.configuration.timeoutIntervalForRequest = 15
        sessionManager.request(r.host + r.path, method: httpMethod, parameters: r.parameters, headers: r.normalHeaders).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
            debugPrint("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    //debugLog(response.result.value)
                    if let value = response.result.value as? [String: AnyObject] {
                        success(value)
                        return
                    }
                    // 未知错误
                    let m = DDErrorModel(status: -11211, message: "返回数据格式不正确")
                    requestError([:], m)
                case .failure(let error):
                    failure(error)
                }
        }
    }
    
    // 图片上传
    func upload<T: BFRequest>(_ r: T, success: @escaping RequestSucceed, failure: @escaping RequestFailure, requestError: @escaping RequestError) {
        debugPrint("请求链接:\(r.host + r.path)")
        debugPrint("请求参数:\( r.parameters ?? [:] )")
        
        // 3.发送网络请求
        sessionManager.session.configuration.timeoutIntervalForRequest = 120
        sessionManager.upload( multipartFormData: { multipartFormData in
            // 图片数据绑定
            for (key, value) in r.parameters! {
                
                if let tempValue = value as? Data {
                    let fileName = key + ".jpg"
                    multipartFormData.append(tempValue, withName: key , fileName: fileName, mimeType: "image/jpeg")
                } else if let imageDict = value as? [String: Data] { // 图片
                    for (imageKey, imageData) in imageDict {
                        let fileName = imageKey + ".jpg"
                        multipartFormData.append(imageData, withName: imageKey , fileName: fileName, mimeType: "image/jpeg")
                    }
                } else if let videosDict = value as? [String: URL] { // 视频
                    for (videoKey, videoURL) in videosDict {
                        let fileName = videoKey + ".mp4"
                        multipartFormData.append(videoURL, withName: videoKey, fileName: fileName, mimeType: "video/mp4")
                    }
                } else {
                    assert(value is String)
                    let utf8Value = (value as AnyObject).data(using: String.Encoding.utf8.rawValue)!
                    multipartFormData.append(utf8Value, withName: key )
                }
            }
        },to: r.host + r.path, headers: r.uploadHeaders, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                    if let value = response.result.value as? [String: AnyObject] {
                        success(value)
                        return
                    }
                    // 未知错误
                    let m = DDErrorModel(status: -11211, message: "返回数据格式不正确")
                    requestError([:], m)
                }
            case .failure(let error):
                failure(error)
                break
            }
        })
    }
    
    // MARK: - lazy load
    private lazy var sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        // 设置请求超时时间
        configuration.timeoutIntervalForRequest = 15
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()
    
}

extension HTTPClient {
    // 请求的方式
    private func getMethod(type: ZHFHTTPMethod) -> HTTPMethod {
        switch type {
        case .POST:
            return HTTPMethod.post
        case .GET:
            return HTTPMethod.get
            
        }
    }
}

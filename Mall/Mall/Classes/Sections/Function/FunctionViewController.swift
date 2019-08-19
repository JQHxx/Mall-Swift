//
//  FunctionViewController.swift
//  Mall
//
//  Created by midland on 2019/7/18.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit

// MARK: - 功能
class FunctionViewController: UIViewController {
    
    // 目标VC
    private var targetVC: UIViewController?
    // 目标参数
    private var targetParams: [String: Any] = [String: Any]()
    // 跳转类型
    private var jumpType = 0
    // 当前VC
    private var currentVC: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // 内容显示到导航下的问题
        edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        viewBindEvents()
        
        let tempView = UIView.init()
        tempView.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        tempView.backgroundColor = UIColor.red
        self.view.addSubview(tempView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let jsonString = "{\"name\":\"zhangsan\",\"age\": 18}"
        
        let jsonData = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data()
        guard let json = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
            return
        }
        
        debugPrint(JSON.init(parseJSON: jsonString))
        
        
//        let dict = ["name": "123"]
//        let json = self.getJSONStringFromDictionary(dictionary: dict)
        debugPrint(json)
        
    }
    
    /**
     字典转换为JSONString
     
     - parameter dictionary: 字典参数
     
     - returns: JSONString
     */
    func getJSONStringFromDictionary(dictionary: [String: Any]) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func injected() {
        viewDidLoad()
        viewWillAppear(true)
        viewDidAppear(true)
    }

}

// MARK: - 登录过期处理逻辑
extension FunctionViewController {
    
    func viewBindEvents() {
        // 检测到未登录调用
        NotificationCenter.default.addObserver(self, selector: #selector(loginAction(noti:)), name: NSNotification.Name.init("Login"), object: nil)
        // 登录成功时调用
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess(noti:)), name: NSNotification.Name.init("LoginSuccess"), object: nil)
    }
    
    // 全局处理登录
    @objc func loginAction(noti: Notification) {
        guard let topVC = self.topViewController() else {
            return
        }
        currentVC = topVC
        debugPrint(noti.object ?? [:])
        let notiInfo = noti.object ?? [:]
        if let tempNotiInfo = notiInfo as? [String: Any] {
            targetParams = tempNotiInfo
            jumpType = (tempNotiInfo["jumpType"] as? Int) ?? 0
            targetVC = tempNotiInfo["targetVC"] as? UIViewController
        } else { // 置空
            targetParams = [:]
            jumpType = 1
            targetVC = nil
        }
        
        if let _ = topVC as? LoginViewController {
            debugPrint("LoginVC")
            return
        }
        let loginNav = MainNavigationController(rootViewController: LoginViewController())
        self.present(loginNav, animated: true) {}
        
    }
    
    @objc func loginSuccess(noti: Notification) {
        // 要刷新页面
        guard let tempCurrentVC = currentVC else {
            return
        }
        
        if jumpType == 1 { // push跳转
            guard let tempTargetVC = targetVC else {
                return
            }
            tempCurrentVC.navigationController?.pushViewController(tempTargetVC, animated: true)
            
        } else if jumpType == 2 { // modal 跳转
            
        } else { // 进入目标VC才跳转（登录过期）直接刷新页面
            /*
            if tempCurrentVC.isKind(of: HFCollectionListMainViewController.self) {
                (tempCurrentVC as? HFCollectionListMainViewController )?.refreshSubViewDatas(param: targetParams)
            }
             */
        }
        
    }
}

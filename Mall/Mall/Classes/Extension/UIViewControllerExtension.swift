//
//  UIViewControllerExtension.swift
//  Mall
//
//  Created by midland on 2019/7/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// 打电话
    ///
    /// - Parameter phone: 电话号码
    func call(phone: String) {
        if #available(iOS 10.2, *) {
            if let telUrl = URL(string: "tel://\(phone)") {
                DispatchQueue.main.async {
                    UIApplication.shared.openURL(telUrl)
                }
            }
        } else {
            let alertView = UIAlertController(title: nil, message: phone, preferredStyle: UIAlertController.Style.alert)
            weak var weakAlertView = alertView
            weak var weakSelf = self
            weakAlertView?.addAction(UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil))
            weakAlertView?.addAction(UIAlertAction(title: "呼叫", style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
                guard let tempURL = URL(string: "tel://\(phone)") else {
                    return
                }
                UIApplication.shared.openURL(tempURL)
            }))
            weakSelf?.present(alertView, animated: true)
        }
    }
    
    // 获取当前的VC
    func topViewController(_ viewController: UIViewController? = nil) -> UIViewController? {
        let viewController = viewController ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = viewController as? UINavigationController,
            !navigationController.viewControllers.isEmpty {
            return self.topViewController(navigationController.viewControllers.last)
            
        } else if let tabBarController = viewController as? UITabBarController,
            let selectedController = tabBarController.selectedViewController {
            return self.topViewController(selectedController)
            
        } else if let presentedController = viewController?.presentedViewController {
            return self.topViewController(presentedController)
            
        }
        
        return viewController
    }
}

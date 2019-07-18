//
//  MainNavigationController.swift
//  Mall
//
//  Created by midland on 2019/7/18.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit

/**
 * 导航公共类， 方便统一处理导航返回按钮
 */
class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
            // 进入新页面隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true
            let backItem = UIBarButtonItem(image: UIImage(named: "Common_Nav_back"), style: .plain, target: self, action: #selector(navigationBackClickAction))
            viewController.navigationItem.leftBarButtonItem = backItem
        }
        //        let backItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
        //        viewController.navigationItem.backBarButtonItem =  backItem
        super.pushViewController(viewController, animated: animated)
        
        // 获取tabBar的frame, 如果没有直接返回
        guard var frame = self.tabBarController?.tabBar.frame else {
            return
        }
        // 设置frame的y值, y = 屏幕高度 - tabBar高度
        frame.origin.y = UIScreen.main.bounds.size.height - frame.size.height
        // 修改tabBar的frame
        self.tabBarController?.tabBar.frame = frame
    }
    
    @objc private func navigationBackClickAction() {
        popViewController(animated: true)
    }

}

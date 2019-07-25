//
//  MainTabBarController.swift
//  Mall
//
//  Created by midland on 2019/7/18.
//  Copyright © 2019 JQHxx. All rights reserved.
//


import Foundation
import UIKit
import CYLTabBarController

/**
 * 主框架
 */
class MainTabBarController: CYLTabBarController {
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupUI()
    }
    
    // MARK: - Private methdos
    func setupRootVC() {
        MainTabBarController.fullFunction()
    }
    
}

extension CYLTabBarController {
    
    class func customizeTabbar() {
        // 普通状态下的文字属性
        var normalAttrs = [NSAttributedString.Key: Any]()
        normalAttrs[NSAttributedString.Key.foregroundColor] = UIColor(red: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 1.0)
        
        // 选中状态下的文字属性
        var selectedAttrs = [NSAttributedString.Key: Any]()
        selectedAttrs[NSAttributedString.Key.foregroundColor] = UIColor(red: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 1.0)
        
        // 设置文字属性
        let tabBar = UITabBarItem.appearance()
        tabBar.setTitleTextAttributes(normalAttrs, for: .normal)
        tabBar.setTitleTextAttributes(selectedAttrs, for: .selected)
        
        // 设置背景图片
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1.0)
    }
    
    /// 全功能界面
    class func fullFunction() {
        
        CYLTabBarController.customizeTabbar()
        
        var vcs = [UIViewController]()
        var dicts = [[String: String]]()
        
        guard let remind = UIStoryboard.init(name: BFStoreboardName.message.rawValue, bundle: nil).instantiateInitialViewController() else {
            return
        }
        vcs += [remind]
        dicts += [[CYLTabBarItemTitle: "消息",
                   CYLTabBarItemImage: "tabbar_message_n",
                   CYLTabBarItemSelectedImage: "tabbar_message_h_b"]]
        
        guard let function = UIStoryboard.init(name: BFStoreboardName.function.rawValue, bundle: nil).instantiateInitialViewController() else {
            return
        }
        vcs += [function]
        dicts += [[CYLTabBarItemTitle: "功能",
                   CYLTabBarItemImage: "tabbar_function_n",
                   CYLTabBarItemSelectedImage: "tabbar_function_h_b"]]
        
       
        let server = ServerViewController()
        let serverNav = MainNavigationController.init(rootViewController: server)
        vcs += [serverNav]
        dicts += [[CYLTabBarItemTitle: "客服",
                   CYLTabBarItemImage: "tabbar_customerservice_n",
                   CYLTabBarItemSelectedImage: "tabbar_customerservice_h_b"]]
        
        guard let mine = UIStoryboard.init(name: BFStoreboardName.mine.rawValue, bundle: nil).instantiateInitialViewController() else {
            return
        }
        vcs += [mine]
        dicts += [[CYLTabBarItemTitle: "我的",
                   CYLTabBarItemImage: "tabbar_mine_n",
                   CYLTabBarItemSelectedImage: "tabbar_mine_h_b"]]
        
        guard dicts.count > 0 else {
            return
        }
        
        let tabVC = CYLTabBarController(viewControllers: vcs,
                                              tabBarItemsAttributes: dicts)
        if let appDelegate = UIApplication.shared.delegate as? UITabBarControllerDelegate {
            tabVC.delegate = appDelegate
        }
        // 默认选中功能
        tabVC.selectedViewController = function
        // UIApplication.sharedDelegate().currentSelectView = function.tabBarItem.cyl_tabButton
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.restoreRootViewController(newRootVC: tabVC)
    }
}


//
//  BFStoreboardName.swift
//  Mall
//
//  Created by midland on 2019/7/25.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit

// MARK: - 主Storeboard的名称
enum BFStoreboardName: String {
    
    // 消息
    case message = "Message"
    
    // 功能
    case function = "Function"

    // 我的
    case mine = "Mine"
    
}

// MARK: - 通过协议加载的方式
protocol StoryboardLoadable {}

extension UIViewController: StoryboardLoadable {}
extension UIView: StoryboardLoadable {}

// MARK: - UIViewController
extension StoryboardLoadable where Self: UIViewController {
    
    // 获取storyboard里面对应的VC
    static func loadStoryboard(_ name: BFStoreboardName) -> Self {
        return UIStoryboard(name: name.rawValue, bundle: nil).instantiateViewController(withIdentifier: "\(self)") as! Self
    }
    
}

// MARK: - UITableViewCell
extension StoryboardLoadable where Self:  UITableViewCell {
    
    static func loadTCell() -> Self {
        return Bundle.main.loadNibNamed(String(describing: Self.self), owner: nil, options: nil)?.first as! Self
    }
    
    static func loadTCell(tableView: UITableView) -> Self? {
        return tableView.dequeueReusableCell(withIdentifier: "\(self)") as? Self
    }
    
    static func loadTCell(tableView: UITableView, indexPath: IndexPath) -> Self {
        return tableView.dequeueReusableCell(withIdentifier: "\(self)", for: indexPath) as! Self
    }
    
}

// MARK: - UICollectionViewCell
extension StoryboardLoadable where Self: UICollectionViewCell {
    
    static func loadCCell(collectionView: UICollectionView, indexPath: IndexPath) -> Self {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "\(self)", for: indexPath) as! Self
    }
    
}

// MARK: - UIView
extension StoryboardLoadable where Self : UIView {
    
    static func loadNib(_ nibNmae: String? = nil) -> Self {
        debugPrint("\(self)")
        let tempNibName = nibNmae ?? "\(self)"
        return Bundle.main.loadNibNamed(tempNibName, owner: nil, options: nil)?.first as! Self
    }
}

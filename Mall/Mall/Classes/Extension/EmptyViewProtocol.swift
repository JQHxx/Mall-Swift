//
//  EmptyViewProtocol.swift
//  Mall
//
//  Created by midland on 2019/8/9.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import UIKit

private var kEmptyViewDelegate = ""
private let emptyViewTag: Int = 350132706

/**
 * 显示空视图协议
 */
protocol EmptyViewDelegate {
    
    /// 用以判断是会否显示空视图
    func showEmtpyView(tableView: UITableView) -> Bool
    
    /// 配置空数据提示图用于展示
    func configEmptyView(tableView: UITableView) -> UIView
}

extension UITableView {
    
    func setEmtpyViewDelegate(_ target: EmptyViewDelegate) {
        self.emptyDelegate = target
        DispatchQueue.once(#function) {
            exchangeMethod(cls: self.classForCoder, targetSel: #selector(self.layoutSubviews), newSel: #selector(self.re_layoutSubviews))
        }
    }
    
    @objc func re_layoutSubviews() {
        self.re_layoutSubviews()
        
        if let tempEmptyView = self.viewWithTag(emptyViewTag) {
            tempEmptyView.removeFromSuperview()
        }
        
        if let delegate = self.emptyDelegate {
            if delegate.showEmtpyView(tableView: self) {
                let emptyView = delegate.configEmptyView(tableView: self)
                emptyView.tag = emptyViewTag
                self.addSubview(emptyView)
                /*
                emptyView.snp.makeConstraints { (make) in
                    make.edges.equalToSuperview()
                }
                 */
            }
        }
        
    }
    
    private var emptyDelegate: EmptyViewDelegate? {
        get {
            return (objc_getAssociatedObject(self, &kEmptyViewDelegate) as? EmptyViewDelegate)
        }
        set (newValue){
            objc_setAssociatedObject(self, &kEmptyViewDelegate, newValue!, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension EmptyViewDelegate {
    func configEmptyView() -> UIView {
        return UIView()
    }
}

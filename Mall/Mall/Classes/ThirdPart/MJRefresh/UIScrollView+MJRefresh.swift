//
//  UIScrollView+MJRefresh.swift
//  Mall
//
//  Created by midland on 2019/8/20.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh

extension UIScrollView {
    
    /// 设置上拉，下拉刷新
    // isNeedFooterRefresh false 则是只有头部刷新  默认有上下拉刷新功能
    func setupRefresh(isNeedFooterRefresh: Bool = true, headerCallback: (() -> Void)?, footerCallBack: (() -> Void)?) {
        
        if let callback = headerCallback {
            self.mj_header = BFRefreshNormalHeader(refreshingBlock: { [weak self] in
                if isNeedFooterRefresh {
                    self?.mj_footer.resetNoMoreData()
                }
                callback()
            })
        }
        
        if isNeedFooterRefresh {
            if let callback = footerCallBack {
                let footer =  BFRefreshBackStateFooter.init(refreshingBlock: {
                    callback()
                })
                footer?.setTitle("亲，已显示全部内容~", for: MJRefreshState.noMoreData)
                self.mj_footer = footer
            }
        }
    }
    
    /// 上拉刷新
    func setupRefresh(footerCallback: (() -> Void)?) {
        
        if let callback = footerCallback {
            let footer =  BFRefreshBackStateFooter.init(refreshingBlock: {
                callback()
            })
            footer?.setTitle("亲，已显示全部内容~", for: MJRefreshState.noMoreData)
            self.mj_footer = footer
        }
    }
    
}


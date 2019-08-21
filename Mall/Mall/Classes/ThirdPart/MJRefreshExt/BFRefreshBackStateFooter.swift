//
//  BFRefreshBackStateFooter.swift
//  Mall
//
//  Created by midland on 2019/8/20.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import Foundation
import MJRefresh

class BFRefreshBackStateFooter: MJRefreshBackStateFooter {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        self.stateLabel.textColor = UIColor.init(red: 94/255.0, green: 219/255.0, blue: 255/255.0, alpha: 1.0)
        self.stateLabel.isHidden = false
        
        for view in self.subviews {
            if view.isKind(of: UIActivityIndicatorView.self) {
                let indicatorView : UIActivityIndicatorView = view as! UIActivityIndicatorView
                indicatorView.color = UIColor.init(red: 94/255.0, green: 219/255.0, blue: 255/255.0, alpha: 1.0)
            }
        }
    }
}

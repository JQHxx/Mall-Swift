//
//  MineViewController.swift
//  Mall
//
//  Created by midland on 2019/7/18.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit

// MARK: - 我的
class MineViewController: UIViewController {

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.setupRefresh(headerCallback: { [weak self] in
            guard let `self` = self else {
                return
            }
            self.tableView.mj_header.endRefreshing()
            
        }) { [weak self] in
            guard let `self` = self else {
                return
            }
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    
    // MARK: - Lazy load
    private lazy var tableView: UITableView = { [weak self] in
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String.init(describing: UITableViewCell.self))
        tableView.dataSource = self
        tableView.tableFooterView = UIView.init()
        return tableView
    }()

}

// MARK: - UITableViewDataSource
extension MineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: UITableViewCell.self))
        if let _ = cell {
            
        } else {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: String.init(describing: UITableViewCell.self))
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
        
    }
    
    
}


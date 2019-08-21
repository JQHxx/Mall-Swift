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
            dispatch_delay(time: 3.0, closure: {
                self.tableView.mj_header.endRefreshing()
            })
            
        }) { [weak self] in
            guard let `self` = self else {
                return
            }
            dispatch_delay(time: 3.0, closure: {
                self.tableView.mj_footer.endRefreshing()
            })
        }
    }
    
    
    // MARK: - Lazy load
    private lazy var tableView: UITableView = { [weak self] in
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        // tableView.separatorInset.left = 0
        let headerView = MineHeaderView.loadNib()
        // headerView.frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: 160)
        tableView.tableHeaderView = headerView
        tableView.register(UINib.init(nibName: "MineCell", bundle: nil), forCellReuseIdentifier: "MineCell")
        tableView.dataSource = self
        tableView.delegate = self
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
        var cell: MineCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MineCell.self)) as? MineCell
        if let _ = cell {
            
        } else {
            cell = Bundle.main.loadNibNamed("MineCell", owner: nil, options: nil)?.last as? MineCell
        }
        cell?.accessoryType = .disclosureIndicator
        cell?.nameLabel.text = "\(indexPath.row)"
        return cell!
        
    }
    
}

// MARK: - UITableViewDelegate
extension MineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


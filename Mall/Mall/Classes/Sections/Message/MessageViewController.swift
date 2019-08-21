//
//  MessageViewController.swift
//  Mall
//
//  Created by midland on 2019/7/18.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit

// MARK: - 消息中心
class MessageViewController: UIViewController {
    
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
        tableView.register(UINib.init(nibName: "MessageListCell", bundle: nil), forCellReuseIdentifier: "MessageListCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView.init()
        return tableView
        }()
    
}

// MARK: - UITableViewDataSource
extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MessageListCell? = tableView.dequeueReusableCell(withIdentifier: String.init(describing: MessageListCell.self)) as? MessageListCell
        if let _ = cell {
            
        } else {
            cell = Bundle.main.loadNibNamed("MessageListCell", owner: nil, options: nil)?.last as? MessageListCell
        }
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
        
    }
    
}

// MARK: - UITableViewDelegate
extension MessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

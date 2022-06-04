//
//  MainListViewController.swift
//  RxSwift-Example-AppleGithub
//
//  Created by kyeoeol on 2022/06/04.
//

import UIKit

class MainListViewController: UITableViewController {
    private let organization = "Apple"
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = organization + "Repositories"
        
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .white
        refreshControl.tintColor = .darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "새로고침")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.refreshControl = refreshControl
        
        tableView.register(MainListCell.self, forCellReuseIdentifier: "MainListCell")
        tableView.rowHeight = 140
    }
    
    // MARK: - Actions
    
    @objc
    func refresh() {
        
    }
}

// MARK: - UITableView DataSource & Delegate

extension MainListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MainListCell",
            for: indexPath
        ) as? MainListCell
        
        return cell ?? UITableViewCell()
    }
}

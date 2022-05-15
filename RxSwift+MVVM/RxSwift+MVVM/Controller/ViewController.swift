//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by kyeoeol on 2022/05/15.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private var disposeBag = DisposeBag()
    
    // MARK: - ViewModel
    
    private let viewModel = ArticleListViewModel()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }
    
    // MARK: - Bind
    
    private func bind() {
        viewModel.articles
            .bind(
                to: self.tableView.rx.items(
                    cellIdentifier: ArticleListCell.identifier,
                    cellType: ArticleListCell.self
                )
            ) { _, item, cell in
                cell.setup(with: item)
            }
            .disposed(by: disposeBag)
    }

    // MARK: - UI
    
    @IBOutlet weak var tableView: UITableView!
}


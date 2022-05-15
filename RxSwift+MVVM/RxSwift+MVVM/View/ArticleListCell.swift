//
//  ArticleListCell.swift
//  RxSwift+MVVM
//
//  Created by kyeoeol on 2022/05/15.
//

import UIKit

class ArticleListCell: UITableViewCell {
    static let identifier = "ArticleListCell"
    
    // MARK: - Setup
    
    func setup(with article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
    }
    
    // MARK: - UI
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}

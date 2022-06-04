//
//  MainListCell.swift
//  RxSwift-Example-AppleGithub
//
//  Created by kyeoeol on 2022/06/04.
//

import UIKit
import SnapKit

class MainListCell: UITableViewCell {
    var repository: String?
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let starImageView = UIImageView()
    let starLabel = UILabel()
    let languageLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [
            nameLabel,
            descriptionLabel,
            starImageView,
            starLabel,
            languageLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }
}

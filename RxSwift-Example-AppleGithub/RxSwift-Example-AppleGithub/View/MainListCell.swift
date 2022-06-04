//
//  MainListCell.swift
//  RxSwift-Example-AppleGithub
//
//  Created by kyeoeol on 2022/06/04.
//

import UIKit
import SnapKit

class MainListCell: UITableViewCell {
    var repository: Repository?
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let starImageView = UIImageView()
    let starLabel = UILabel()
    let languageLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // MARK: - Add Subview
        
        [
            nameLabel,
            descriptionLabel,
            starImageView,
            starLabel,
            languageLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        nameLabel.text = repository?.name
        nameLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        descriptionLabel.text = repository?.description
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 2
        
        starImageView.image = UIImage(systemName: "star")
        
        starLabel.text = "\(repository?.stargazersCount ?? 0)"
        starLabel.font = .systemFont(ofSize: 16)
        starLabel.textColor = .gray
        
        languageLabel.text = repository?.language
        languageLabel.font = .systemFont(ofSize: 16)
        languageLabel.textColor = .gray
        
        // MARK: - AutoLayout
        
        nameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(18)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(3)
            $0.leading.trailing.equalTo(nameLabel)
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.equalTo(descriptionLabel)
            $0.bottom.equalToSuperview().inset(18)
            $0.size.equalTo(20)
        }
        
        starLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView)
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
        }
        
        languageLabel.snp.makeConstraints {
            $0.centerY.equalTo(starLabel)
            $0.leading.equalTo(starLabel.snp.trailing).offset(12)
        }
    }
}

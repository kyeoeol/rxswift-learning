//
//  ArticleModel.swift
//  RxSwift+MVVM
//
//  Created by kyeoeol on 2022/05/15.
//

import Foundation

struct ArticleList: Decodable {
    static let placeholder = ArticleList(articles: [])
    
    let articles: [Article]
}

struct Article: Decodable {
    var title: String?
    var description: String?
}

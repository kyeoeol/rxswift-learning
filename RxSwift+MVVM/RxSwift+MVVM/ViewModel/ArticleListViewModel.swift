//
//  ArticleListViewModel.swift
//  RxSwift+MVVM
//
//  Created by kyeoeol on 2022/05/15.
//

import Foundation
import RxSwift
import Moya
import RxMoya

class ArticleListViewModel {
    private var disposeBag = DisposeBag()
    // MARK: - ArticleService
    
    private let provider = MoyaProvider<ArticleService>()
    
    // MARK: - Articles
    
    var articles = PublishSubject<[Article]>()
    
    // MARK: - Fetch Data
    
    func fetchData() {
        provider.rx.request(.getArticles)
            .map(
                ArticleList.self,
                using: JSONDecoder(),
                failsOnEmptyData: false
            )
            .map { $0.articles }
            .asObservable()
            .subscribe(articles)
            .disposed(by: disposeBag)
    }
}

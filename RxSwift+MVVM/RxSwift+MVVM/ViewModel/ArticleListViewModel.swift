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
            .filterSuccessfulStatusCodes()
            .map(ArticleList.self)
            .map(\.articles)
            .asObservable()
            .subscribe(onNext: { communityList in
                self.articles.onNext(communityList)
            }, onError: { error in
                print("--->ERROR:", error)
            })
            .disposed(by: disposeBag)
    }
}

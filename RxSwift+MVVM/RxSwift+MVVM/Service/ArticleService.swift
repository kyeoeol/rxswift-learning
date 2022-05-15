//
//  ArticleService.swift
//  RxSwift+MVVM
//
//  Created by kyeoeol on 2022/05/15.
//

import Foundation
import Moya

enum ArticleService {
    case getArticles
}

extension ArticleService: TargetType {
    // MARK: - Base URL
    
    var baseURL: URL { URL(string: "https://newsapi.org")! }
    
    // MARK: - Path
    
    var path: String {
        switch self {
        case .getArticles:
            return "/v2/top-headlines"
        }
    }
    
    // MARK: - Method
    
    var method: Moya.Method {
        switch self {
        case .getArticles:
            return .get
        }
    }
    
    // MARK: - Task
    
    var task: Task {
        switch self {
        case .getArticles:
            return .requestParameters(
                parameters: [
                    "country": "us",
                    "apiKey": "e9b514c39c5f456db8ed4ecb693b0040"
                ],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    // MARK: - Headers
    
    var headers: [String : String]? { nil }
}

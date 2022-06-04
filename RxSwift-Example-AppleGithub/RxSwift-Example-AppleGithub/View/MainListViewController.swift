//
//  MainListViewController.swift
//  RxSwift-Example-AppleGithub
//
//  Created by kyeoeol on 2022/06/04.
//

import UIKit
import RxSwift
import RxCocoa

class MainListViewController: UITableViewController {
    // MARK: - Properties
    
    private let organization = "Apple"
    private let repositories = BehaviorSubject<[Repository]>(value: [])
    private var disposeBag = DisposeBag()
    
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
        DispatchQueue.global(qos: .background).async {
            self.fetchRepositories(of: self.organization)
        }
    }
    
    func fetchRepositories(of organization: String) {
        Observable.from([organization])
            .map { organization -> URL in
                return URL(string: "https://api.github.com/orgs/\(organization)/repos")!
            }
            .map { url -> URLRequest in
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                return request
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            .filter { response, _ in
                return (200..<300).contains(response.statusCode)
            }
            .map { _, data -> [[String: Any]] in
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                      let result = json as? [[String: Any]] else {
                    return []
                }
                return result
            }
            .filter { result in
                return result.count > 0
            }
            .map { objects in
                return objects.compactMap { dic -> Repository? in
                    guard let id = dic["id"] as? Int,
                          let name = dic["name"] as? String,
                          let description = dic["description"] as? String,
                          let stargazersCount = dic["stargazers_count"] as? Int,
                          let language = dic["language"] as? String
                    else {
                        return nil
                    }
                    return Repository(id: id, name: name, description: description, stargazersCount: stargazersCount, language: language)
                }
            }
            .subscribe(onNext: { [weak self] repositories in
                self?.repositories.onNext(repositories)
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.refreshControl?.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableView DataSource & Delegate

extension MainListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try repositories.value().count
        }
        catch {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MainListCell",
            for: indexPath
        ) as? MainListCell
        
        var currentRepo: Repository? {
            do {
                return try repositories.value()[indexPath.row]
            }
            catch {
                return nil
            }
        }
        cell?.repository = currentRepo
        
        return cell ?? UITableViewCell()
    }
}

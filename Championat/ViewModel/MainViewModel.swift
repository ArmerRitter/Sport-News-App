//
//  MainViewModel.swift
//  Championat
//
//  Created by Yuriy Balabin on 27.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation


protocol MainViewModelType: class {
    var numberOfPage: Box<Int> { get set }
    var numberOfNewArticles: Box<Int> { get set }
    func numberOfItems() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ArticleCellViewModelType?
    func viewModelForSelectedArticle(forIndexPath indexPath: IndexPath) -> DetailsViewModelType?
    func getArticles(_ page: Int)
    func autoRefresh()
    init(networkService: NetworkServiceProtocol)
}

class MainViewModel: MainViewModelType {
    
    
    var networkService: NetworkServiceProtocol!
    var articles = [Article]()
    var refreshTimer: Timer?
    var numberOfPage: Box<Int> = Box(0)
    var numberOfNewArticles: Box<Int> = Box(0)
    
    func numberOfItems() -> Int {
        return articles.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ArticleCellViewModelType? {
        
        let article = articles[indexPath.row]
        return ArticleCellViewModel(article: article, networkService: networkService)
    }
    
    func viewModelForSelectedArticle(forIndexPath indexPath: IndexPath) -> DetailsViewModelType? {
        
        let article = articles[indexPath.row]
        return DetailsViewModel(articleURL: article.detailsURL, networkServise: networkService)
    }
    
    func getArticles(_ page: Int) {
        networkService.getArticles(page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    var newArticles = [Article]()
                    
                    guard let articles = articles else { return }
                    
                    newArticles = articles.filter {
                        !(self.articles.contains($0))
                    }
                    
                    self.articles.append(contentsOf: newArticles)
                    self.numberOfPage.value += 1
               
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
    @objc func articlesUpdate() {
        networkService.getArticles(1) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    var newArticles = [Article]()
                    
                    guard let articles = articles else { return }
                    
                    newArticles = articles.filter {
                        !(self.articles.contains($0))
                    }
                    
                    if newArticles.count > 24 {
                        self.articles.removeAll()
                        self.articles.append(contentsOf: newArticles)
                        self.numberOfPage.value = 1
                        return
                    }
                    
                    if !newArticles.isEmpty {
                        self.articles = newArticles + self.articles
                        self.numberOfNewArticles.value += newArticles.count
                    }
                    
                
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func autoRefresh() {
        refreshTimer = Timer.scheduledTimer(timeInterval: 120, target: self, selector: #selector(articlesUpdate), userInfo: nil, repeats: true)
    }
    
    required init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        getArticles(1)
        autoRefresh()
    }
    
    
}

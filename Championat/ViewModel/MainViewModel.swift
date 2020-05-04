//
//  MainViewModel.swift
//  Championat
//
//  Created by Yuriy Balabin on 27.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation


protocol MainViewModelType: class {
    func numberOfItems() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ArticleCellViewModelType?
    func getArticles(_ page: Int)
    var numberOfArticle: Box<Int> { get set }
    init(networkService: NetworkServiceProtocol)
}

class MainViewModel: MainViewModelType {
    
    
    var networkService: NetworkServiceProtocol!
    var articles: [Article]? = []
    var numberOfArticle: Box<Int> = Box(0)
    
    func numberOfItems() -> Int {
        return articles?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ArticleCellViewModelType? {
        
        guard let articles = articles else { return nil }
        
        let article = articles[indexPath.row]
        return ArticleCellViewModel(article: article, networkService: networkService)
    }
    
    func getArticles(_ page: Int) {
        networkService.getArticles(page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self.articles?.append(contentsOf: articles!)
                    self.numberOfArticle.value += 1
                  //  print(articles)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    required init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        getArticles(1)
    }
    
    
}

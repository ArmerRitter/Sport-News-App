//
//  DetailsViewModel.swift
//  Championat
//
//  Created by Yuriy Balabin on 16.05.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

protocol DetailsViewModelType {
    var articleIsReady: Box<Bool> { get set }
    func numberOfItems() -> Int
    func bodyCellViewModel(forIndexPath indexPath: IndexPath) -> DetailsBodyCellViewModelType?
    func headerCellViewModel(forIndexPath indexPath: IndexPath) -> DetailsHeaderCellViewModelType?
    func getDetails(detailsURL: String) 
}

class DetailsViewModel: DetailsViewModelType {
    
    private var articleDetails: ArticleDetails = ArticleDetails(header: ArticleHeader(title: "", subTitle: "", headPhotoURL: ""), body: [])
    
    var networkServise: NetworkServiceProtocol!
    var articleIsReady: Box<Bool> = Box(false)
    
    func numberOfItems() -> Int {
        return articleDetails.body.count
    }
    
    func headerCellViewModel(forIndexPath indexPath: IndexPath) -> DetailsHeaderCellViewModelType? {

        let header = articleDetails.header
        return DetailsHeaderCellViewModel(articleHeader: header, networkService: networkServise)
    }
    
    func bodyCellViewModel(forIndexPath indexPath: IndexPath) -> DetailsBodyCellViewModelType? {
        
       
        let content = articleDetails.body[indexPath.row]
        return DetailsBodyCellViewModel(articleContent: content, networkService: networkServise)
    }
    
    func getDetails(detailsURL: String) {
        
        networkServise.getArticleDetails(url: detailsURL) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let article):
                    
                    guard let article = article else { return }
                    
                    self.articleDetails = article
                    self.articleIsReady.value.toggle()
                }
            }
        }
    }
    
    
    init(articleURL: String, networkServise: NetworkServiceProtocol) {
        self.networkServise = networkServise
        getDetails(detailsURL: articleURL)
    }
}

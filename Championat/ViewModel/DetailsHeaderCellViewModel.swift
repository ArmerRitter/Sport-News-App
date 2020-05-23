//
//  DetailsHeaderCellViewModel.swift
//  Championat
//
//  Created by Yuriy Balabin on 23.05.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

protocol DetailsHeaderCellViewModelType: class {
    var articleTitle: String { get }
    var articleSubtitle: String { get }
    var headPhoto: Box<UIImage?> { get set }
    func getImage(headPhotoURL: String)
    init(articleHeader: ArticleHeader, networkService: NetworkServiceProtocol)
}


class DetailsHeaderCellViewModel: DetailsHeaderCellViewModelType {
   
    var networkService: NetworkServiceProtocol
    var articleHeader: ArticleHeader
    
    var articleTitle: String {
        return articleHeader.title
    }
    
    var articleSubtitle: String {
        return articleHeader.subTitle
    }
    
    var headPhoto: Box<UIImage?> = Box(nil)
    

    
    func getImage(headPhotoURL: String) {
        
        networkService.getArticleImage(url: headPhotoURL) { result in
                DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                    self.headPhoto.value = UIImage(named: "default_Image")!
                case .success(let image):
                    self.headPhoto.value = image!
                }
              }
           }
        
    }
    
    required init(articleHeader: ArticleHeader, networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        self.articleHeader = articleHeader
      
        getImage(headPhotoURL: articleHeader.headPhotoURL)
  }
}


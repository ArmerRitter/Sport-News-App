//
//  ArticleCellViewModel.swift
//  Championat
//
//  Created by Yuriy Balabin on 27.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

protocol ArticleCellViewModelType: class {
    var articleImage: Box<UIImage?> { get set }
    var articleTitle: String { get }
    var articleDate: String { get }
    var sportTagColor: UIColor { get }
    var sportTagLabel: String { get }
    func getImage()
}


class ArticleCellViewModel: ArticleCellViewModelType {
    
   
    private var article: Article
    private let imageQueue = DispatchQueue(label: "Image Fetching", attributes: .concurrent)
    var networkService: NetworkServiceProtocol!
    
    var articleImage: Box<UIImage?> = Box(nil)
    
    var articleTitle: String {
        return article.title
    }
    
    var articleDate: String {
        return article.date
    }
    
    var sportTagColor: UIColor {
        
        switch article.sportTag {
        case "Футбол":
            return .footballColor
        case "Хоккей":
            return .hockeyColor
        case "Бокс/ММА":
            return .boxAndMMAColor
        case "Теннис":
            return .tennisColor
        case "Авто":
            return .autoColor
        case "Ставки":
            return .betColor
        case "Lifestyle":
            return .lifeStyleColor
        case "Киберспорт":
            return .cyberSportColor
        case "Баскетбол":
            return .basketballColor
        default:
            return .otherColor
        }
        
        
    }
    
    var sportTagLabel: String {
       return "• " + article.sportTag + " •"
    }
    
    func getImage() {
      
        networkService.getArticleImage(url: article.imageURL) { result in
                DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                    self.articleImage.value = UIImage(named: "default_Image")!
                case .success(let image):
                    self.articleImage.value = image!
                    print(image, "succ")
                   
                }
              }
           }
       
    }
    
    init(article: Article, networkService: NetworkServiceProtocol) {
        self.article = article
        self.networkService = networkService
       
        getImage()
    }
}

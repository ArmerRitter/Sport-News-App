//
//  DetailsCellViewModel.swift
//  Championat
//
//  Created by Yuriy Balabin on 18.05.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit


protocol DetailsBodyCellViewModelType: class {
    var contentText: String? { get }
    var contentHeader: String? { get }
    var contentImage: Box<UIImage?> { get set }
    var type: CellType { get }
    func getImage(imageURL: String)
    init(articleContent: [ContentTag:String], networkService: NetworkServiceProtocol)
}

enum CellType: String {
    case text
    case image
}

class DetailsBodyCellViewModel: DetailsBodyCellViewModelType {
   
    var articleContent: [ContentTag:String]
    var networkService: NetworkServiceProtocol!
    
    var contentText: String? {
        guard let text = articleContent[.text] else { return nil }
        return text
    }
    
    var contentHeader: String? {
        guard let header = articleContent[.header] else { return nil }
        return header
    }
    
    var contentImage: Box<UIImage?> = Box(nil)
    
    var type: CellType {
        return (articleContent[.photoURL] != nil) ? CellType.image : CellType.text
    }
    
    
    func getImage(imageURL: String) {
        
        networkService.getArticleImage(url: imageURL) { result in
                DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                    self.contentImage.value = UIImage(named: "default_Image")!
                case .success(let image):
                    self.contentImage.value = image!
                }
              }
           }
        
    }
    
    required init(articleContent: [ContentTag:String], networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        self.articleContent = articleContent
        
        guard let photoURL = articleContent[.photoURL] else { return }
        getImage(imageURL: photoURL)
        
  }
}

//
//  NetworkManager.swift
//  Championat
//
//  Created by Yuriy Balabin on 29.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

protocol NetworkServiceProtocol {
    func getArticles(_ page: Int, completion: @escaping (Result<[Article]?,Error>) -> Void)
    func getArticleDetails(url: String, completion: @escaping (Result<ArticleDetails?,Error>) -> Void)
    func getArticleImage(url: String, completion: @escaping (Result<UIImage?,Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    
    
    func getArticles(_ page: Int, completion: @escaping (Result<[Article]?,Error>) -> Void) {
        
        let baseURL = URL(string: "https://www.championat.com/articles")
        
        guard let artilcesURL = baseURL?.appendingPathComponent("\(page).html")
            else { fatalError("url could not be configured") }
        
        URLSession.shared.dataTask(with: artilcesURL)  { (data: Data?, response, error) in
          
        if let error = error {
            completion(.failure(error))
            return
        }
            
            guard let data = data, let content = String(data: data, encoding: .utf8) else { return }
            
           
            
            let articles = ParserService().decodeArticlesList(htmlContent: content)
            completion(.success(articles))
            
        }.resume()
    }
    
    func getArticleDetails(url: String, completion: @escaping (Result<ArticleDetails?,Error>) -> Void) {
        
        let baseURL = URL(string: "https://www.championat.com")
        
        guard let artilceDetailsURL = baseURL?.appendingPathComponent(url)
            else { fatalError("url could not be configured") }
        
        URLSession.shared.dataTask(with: artilceDetailsURL)  { (data: Data?, response, error) in
          
        if let error = error {
            completion(.failure(error))
            return
        }
            
            guard let data = data, let content = String(data: data, encoding: .utf8) else { return }
            
           
            
            let article = ParserService().decodeArticleDetails(htmlContent: content)
            completion(.success(article))
            
        }.resume()
    }
    
    func getArticleImage(url: String, completion: @escaping (Result<UIImage?,Error>) -> Void) {
        
        guard let imageURL = URL(string: url) else {
            return
        }
   
        URLSession.shared.dataTask(with: imageURL)  { (data: Data?, response, error) in
                 
                if let error = error {
                    completion(.failure(error))
                    return
                }
                    
                    guard let data = data, let image = UIImage(data: data) else { return }
                    
                 //  print(data)
                    completion(.success(image))
                    
                }.resume()
    }
    
    
    
}

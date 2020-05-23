//
//  Parser.swift
//  Championat
//
//  Created by Yuriy Balabin on 29.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation
import SwiftSoup

class ParserService {
    
    func decodeArticlesList(htmlContent: String) -> [Article] {
        var articles = [Article]()
        
        do {
            let doc: Document = try SwiftSoup.parse(htmlContent)
            
            let elements = try doc.getElementsByClass("article-preview").array()
            
            try elements.map {
            
                articles.append(Article(imageURL: try $0.select("img").attr("data-src"), title: try $0.select("a.article-preview__title").html(), date: try $0.select("div.article-preview__date").html(), sportTag: try $0.select("a.article-preview__tag").html(), detailsURL: try $0.select("a").attr("href")))
             }
            
        } catch {
            
        }
        return articles
    }
    
    func decodeArticleDetails(htmlContent: String) -> ArticleDetails {
        
        var article: ArticleDetails = ArticleDetails(header: ArticleHeader(title: "", subTitle: "", headPhotoURL: ""), body: [])
        
        do {
            let doc: Document = try SwiftSoup.parse(htmlContent)
            
            let content = try doc.getElementsByClass("article lp_article_content").array()
            
            let header = try content[0].getElementsByClass("article-head _no-border js-copyright-content")
     
            let photoURL = try header.select("div.article-head__photo").select("img").attr("src")
           
            let articleTitle = try header.select("div.article-head__title").html()
            
            let articleSubtitle = try header.select("div.article-head__subtitle").html()
            
            article.header.title = articleTitle
            article.header.subTitle = articleSubtitle
            article.header.headPhotoURL = photoURL
            
            let body = try content[0].getElementsByClass("article-content js-content-banners-wrapper js-copyright-content")
            
            let articleDetails = try body.first()?.children().array()
          
            try articleDetails?.forEach {
                
                let tag = try $0.tagName()
                
                switch tag {
                case "p":
                    article.body.append([ContentTag.text: try $0.text()])
                case "h4":
                    article.body.append([ContentTag.header: try $0.text()])
                case "div":
                    if try $0.attr("class") == "content-photo" {
                        article.body.append([ContentTag.photoURL: try $0.select("img").attr("src")])
                    }
                default:
                    return
                }
            }
            
            
        } catch {
            
        }
        
        return article
    }
    
}

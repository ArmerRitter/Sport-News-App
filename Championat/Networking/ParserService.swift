//
//  Parser.swift
//  Championat
//
//  Created by Yuriy Balabin on 29.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation
import SwiftSoup

class Parser {
    
    
    func decode(htmlContent: String) -> [Article] {
        var articles = [Article]()
        
        do {
            let doc: Document = try SwiftSoup.parse(htmlContent)
            
            let elements = try doc.getElementsByClass("article-preview").array()
            
            try elements.map {
            
                 articles.append(Article(imageURL: try $0.select("img").attr("data-src"), title: try $0.select("a.article-preview__title").html(), date: try $0.select("div.article-preview__date").html(), sportTag: try $0.select("a.article-preview__tag").html()))
             }
            
        } catch {
            
        }
        return articles
    }
}

//
//  ViewController.swift
//  Championat
//
//  Created by Yuriy Balabin on 20.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController {

    var content: String!
    
    let dateLabelButton: UIButton = {
        let button = UIButton()
        //button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: 100, y: 300, width: 100, height: 100)
        button.layer.cornerRadius = 10
        button.backgroundColor = .black

        
        button.layer.borderColor = UIColor.yellow.cgColor
        button.layer.borderWidth = 2
        //let shadow = UIBezierPath(roundedRect: button.bounds, cornerRadius: 10).cgPath
        button.layer.shadowRadius = 5
        button.layer.shadowColor = UIColor.yellow.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: -10.0)
        button.layer.shadowOpacity = 1.5
        button.layer.masksToBounds = false
       // button.layer.shadowPath = shadow

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       
            //#colorLiteral(red: 0.02745098039, green: 0.1333333333, blue: 0.2156862745, alpha: 1)
        view.addSubview(dateLabelButton)
        getRequest()
        
        //parse()
    }

    let session = URLSession.shared
    func getRequest() {
        
        let baseUrl = URL(string: "https://www.championat.com/articles")
         let url = baseUrl?.appendingPathComponent("1.html")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        
        session.dataTask(with: request) { (data: Data?, response, error) in
            
            guard let responseData = data else { return }
            
            guard let htmlContent = String(data: responseData, encoding: .utf8) else { return }
            
            do {
                       let doc: Document = try SwiftSoup.parse(htmlContent)
                
                var article = [Article]()
                
                var arr: [Element] = try doc.select("div").filter { try $0.attr("class") == "article-preview" }
                
                var articles = try doc.getElementsByClass("article-preview")
               // let res: String = classes.
                
               let dd = try arr.map {
               
                    article.append(Article(imageURL: try $0.select("img").attr("data-src"), title: try $0.select("a.article-preview__title").html(), date: try $0.select("div.article-preview__date").html(), sportTag: try $0.select("a.article-preview__tag").html()))
                }
                
                print(article)
                
                let img = try arr[3].select("img").attr("data-src")
                
                let title = try arr[3].select("a.article-preview__title").html()
                    //try arr[3].select("a").get(1).html()
              //  let subtitle = try arr[3].select("a.article-preview__subtitle").html()
                let date = try arr[3].select("div.article-preview__date").html()
                let tag = try arr[3].select("a.article-preview__tag").html()

                //print(img,"\n",
                //      title,"\n","\n",date,"\n",tag,"\n")
                
                let tit = try arr.map { try $0.select("a.article-preview__title").html() }
                
                
                   } catch  {
                       print(error)
                   }
            
        }.resume()
        
    }
    
    func parse() {
        
   
    }
    
}


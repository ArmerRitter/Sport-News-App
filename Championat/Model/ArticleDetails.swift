//
//  ArticleDetails.swift
//  Championat
//
//  Created by Yuriy Balabin on 18.05.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

enum ContentTag {
    case text
    case header
    case photoURL
}

struct ArticleHeader {
    
    var title: String
    var subTitle: String
    var headPhotoURL: String
}

struct ArticleDetails {
    
    var header: ArticleHeader
    var body: [[ContentTag:String]]
}

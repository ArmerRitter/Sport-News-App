//
//  DetailsTextCell.swift
//  Championat
//
//  Created by Yuriy Balabin on 21.05.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class DetailsBodyTextCell: UITableViewCell {
    
    weak var viewModel: DetailsBodyCellViewModelType? {
          willSet(viewModel) {
              guard let viewModel = viewModel else { return }
    
            articleText.text = viewModel.contentText
            articleText.setLineSpacing(lineSpacing: 5)
            articleSubheader.text = viewModel.contentHeader
            
          }
      }
    
    let articleText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        
        label.sizeToFit()
        return label
    }()
    
    let articleSubheader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(articleText)
        addSubview(articleSubheader)
        
        articleText.topAnchor.constraint(equalTo: topAnchor, constant:  15).isActive = true
        articleText.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  15).isActive = true
        articleText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        articleText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        articleSubheader.topAnchor.constraint(equalTo: topAnchor, constant:  15).isActive = true
        articleSubheader.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  15).isActive = true
        articleSubheader.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        articleSubheader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

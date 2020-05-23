//
//  DetailsHeaderCell.swift
//  Championat
//
//  Created by Yuriy Balabin on 23.05.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit



class DetailsHeaderCell: UITableViewCell {
    
    weak var viewModel: DetailsHeaderCellViewModelType? {
          willSet(viewModel) {
              guard let viewModel = viewModel else { return }
    
            articleTitleLabel.text = viewModel.articleTitle
            articleSubtitleLabel.text = viewModel.articleSubtitle
          }
      }
    
    
   let articleTitleLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.numberOfLines = 3
       label.font = .boldSystemFont(ofSize: 21)
       label.textAlignment = .left
       return label
   }()
    
    let articleSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 19)
        label.textAlignment = .left
        return label
    }()
    
    var articleHeadPhotoImageView: UIImageView = {
        let screen = UIScreen.main.bounds
        let image = UIImageView()
       image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
       return image
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
     
       addSubview(articleHeadPhotoImageView)
       addSubview(articleTitleLabel)
       addSubview(articleSubtitleLabel)
        
        articleSubtitleLabel.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor, constant:  5).isActive = true
        articleSubtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  15).isActive = true
        articleSubtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        articleSubtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        
        articleTitleLabel.topAnchor.constraint(equalTo: articleHeadPhotoImageView.bottomAnchor, constant:  15).isActive = true
        articleTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  15).isActive = true
        articleTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true

        
        articleHeadPhotoImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        articleHeadPhotoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  0).isActive = true
        articleHeadPhotoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  0).isActive = true
        articleHeadPhotoImageView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        articleHeadPhotoImageView.heightAnchor.constraint(equalToConstant: (frame.width) * 0.8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

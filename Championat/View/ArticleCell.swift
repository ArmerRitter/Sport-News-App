//
//  ArticleCollectionViewCell.swift
//  Championat
//
//  Created by Yuriy Balabin on 24.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class ArticleCell: UICollectionViewCell {
    
    weak var viewModel: ArticleCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
  
            articleTitleLabel.text = viewModel.articleTitle
            articleDateLabel.text = viewModel.articleDate
            sportTagColorView.backgroundColor = viewModel.sportTagColor
            sportTagLabel.text = viewModel.sportTagLabel
            sportTagLabel.textColor = viewModel.sportTagColor
        }
    }
    
    
    let articleTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = .boldSystemFont(ofSize: 15)
       // label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
    }()
    
    let articleDateLabel: UILabel = {
        let label = UILabel()
    //    label.text = "24 апреля 2020, 23:30"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = true
       // label.backgroundColor = .yellow
        label.textAlignment = .left
        return label
    }()
    
    let sportTagLabel: UILabel = {
        let label = UILabel()
    //    label.text = "24 апреля 2020, 23:30"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
       // label.textColor = .gray
        label.adjustsFontSizeToFitWidth = true
     //   label.backgroundColor = .lightGray
        label.textAlignment = .right
        return label
    }()
    
    let articleImage: UIImageView = {
        let image = UIImageView()
        //image.image = UIImage(named: "kokor")
       // image.contentMode = .scaleToFill
       // image.backgroundColor = .red
       image.translatesAutoresizingMaskIntoConstraints = false
       return image
    }()

    let sportTagColorView: UIView = {
       let view = UIView()
       view.backgroundColor = .lifeStyleColor
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let articleDetailsStackView = UIStackView(arrangedSubviews: [articleDateLabel,sportTagLabel])
        articleDetailsStackView.axis = .horizontal
        articleDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        articleDetailsStackView.distribution = .fill
        
        addSubview(articleImage)
        addSubview(sportTagColorView)
        addSubview(articleTitleLabel)
        addSubview(articleDetailsStackView)
        
        articleDetailsStackView.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor).isActive = true
        articleDetailsStackView.leadingAnchor.constraint(equalTo: articleTitleLabel.leadingAnchor).isActive = true
        articleDetailsStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        articleDetailsStackView.trailingAnchor.constraint(equalTo: articleTitleLabel.trailingAnchor).isActive = true
        
//        sportTagLabel.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor).isActive = true
//        sportTagLabel.leadingAnchor.constraint(equalTo: articleDateLabel.trailingAnchor,constant: 0).isActive = true
//        sportTagLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
//        sportTagLabel.trailingAnchor.constraint(equalTo: articleTitleLabel.trailingAnchor).isActive = true
//
//        articleDateLabel.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor).isActive = true
//        articleDateLabel.leadingAnchor.constraint(equalTo: articleImage.trailingAnchor,constant: 10).isActive = true
//        articleDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
//        articleDateLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        
        articleTitleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        articleTitleLabel.leadingAnchor.constraint(equalTo: articleImage.trailingAnchor,constant: 10).isActive = true
        articleTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        articleTitleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true

        
        articleImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        articleImage.leadingAnchor.constraint(equalTo: sportTagColorView.trailingAnchor, constant: 3).isActive = true
        articleImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        articleImage.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        
        sportTagColorView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        sportTagColorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sportTagColorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        sportTagColorView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.masksToBounds = true
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

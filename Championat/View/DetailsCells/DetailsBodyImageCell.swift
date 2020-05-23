//
//  DetailsImageCell.swift
//  Championat
//
//  Created by Yuriy Balabin on 21.05.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class DetailsBodyImageCell: UITableViewCell {
    
    weak var viewModel: DetailsBodyCellViewModelType? 
    
    var articlePhotoImageView: UIImageView = {
       let image = UIImageView()
       image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
       return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(articlePhotoImageView)
        
        articlePhotoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        articlePhotoImageView.topAnchor.constraint(equalTo: topAnchor, constant:  15).isActive = true
        articlePhotoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        articlePhotoImageView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        articlePhotoImageView.heightAnchor.constraint(equalToConstant: (frame.width) * 0.8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

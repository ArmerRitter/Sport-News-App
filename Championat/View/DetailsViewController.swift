//
//  DetailsViewController.swift
//  Championat
//
//  Created by Yuriy Balabin on 16.05.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class DetailsViewController: UITableViewController {
    
    var viewModel: DetailsViewModelType?
    let cellTextId = "TextCell"
    let cellImageId = "ImageCell"
    let cellHeaderId = "HeaderCell"
    
    let titleImage: UIImageView = {
       let imageView = UIImageView()
       let image = UIImage(named: "logo8")
       imageView.contentMode = .scaleAspectFit
       imageView.image = image
       return imageView
    }()
    
//MARK: ViewDidload
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = titleImage
        
        viewModel?.articleIsReady.bind(listener: { [unowned self] ready in
            self.tableView.reloadData()
        })
        
        tableView.separatorStyle = .none
        tableView.register(DetailsBodyTextCell.self, forCellReuseIdentifier: cellTextId)
        tableView.register(DetailsBodyImageCell.self, forCellReuseIdentifier: cellImageId)
        tableView.register(DetailsHeaderCell.self, forCellReuseIdentifier: cellHeaderId)
        
    }
    
//MARK: Initialization
    
    init(viewModel: DetailsViewModelType) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

 //MARK: TableViewDataSource

extension DetailsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
        return viewModel?.numberOfItems() ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let viewModel = viewModel else { return UITableViewCell() }
        //header cell
        if indexPath.section == 0 {
         
            let cell = tableView.dequeueReusableCell(withIdentifier: cellHeaderId, for: indexPath) as? DetailsHeaderCell
            cell?.selectionStyle = .none
            
            guard let tableViewHeaderCell = cell else { return UITableViewCell() }
            
          guard let cellViewModel = viewModel.headerCellViewModel(forIndexPath: indexPath) else { return UITableViewCell() }
           
            tableViewHeaderCell.viewModel = cellViewModel
            
            cellViewModel.headPhoto.bind {
                tableViewHeaderCell.articleHeadPhotoImageView.image = $0
            }
            return tableViewHeaderCell
        } else {
        //body cells
       guard let cellViewModel = viewModel.bodyCellViewModel(forIndexPath: indexPath) else { return UITableViewCell() }
        
        let typeCell = cellViewModel.type
        
        switch typeCell {
        case CellType.text:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellTextId, for: indexPath) as? DetailsBodyTextCell
                cell?.selectionStyle = .none
            
                guard let tableViewTextCell = cell else { return UITableViewCell() }
            
                tableViewTextCell.viewModel = cellViewModel
                return tableViewTextCell
        case CellType.image:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellImageId, for: indexPath) as? DetailsBodyImageCell
            cell?.selectionStyle = .none
            
            guard let tableViewImageCell = cell else { return UITableViewCell() }
            
            tableViewImageCell.viewModel = cellViewModel
          
            cellViewModel.contentImage.bind {
                tableViewImageCell.articlePhotoImageView.image = $0
            }
            return tableViewImageCell
        }
      }
       // return UITableViewCell()
    }
}

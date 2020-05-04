//
//  MainCollectionViewController.swift
//  Championat
//
//  Created by Yuriy Balabin on 24.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit


class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "ArticleCell"
    let logo = UIImage(named: "logo8")
    var getNewPageFlag = false
    
    var viewModel: MainViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.numberOfArticle.bind(listener: { [unowned self] number in
            self.collectionView.reloadData()
            self.getNewPageFlag = true
        })
        
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02745098039, green: 0.1333333333, blue: 0.2156862745, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = logo
        navigationItem.titleView = imageView
        
        collectionView.backgroundColor = .white
       // collectionView.indicatorStyle = .white
        
        let newRecordButton: UIBarButtonItem = {
            let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
            return button
        }()
        
        navigationItem.rightBarButtonItem = newRecordButton
        
        // Register cell classes
        self.collectionView!.register(ArticleCell.self, forCellWithReuseIdentifier: cellId)
        
        print(viewModel?.numberOfItems(), "num")
        // Do any additional setup after loading the view.
    }
    
    @objc func add() {
        collectionView.reloadData()
        collectionView.setNeedsLayout()
    }
    
//    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        var bottom = scrollView.contentOffset.y + scrollView.frame.size.height
//        if bottom >= scrollView.contentSize.height - 100 {
//            viewModel?.getArticles((viewModel?.numberOfArticle.value)! + 1)
//        }
//    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottom = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottom >= scrollView.contentSize.height - 400 && getNewPageFlag {
             getNewPageFlag = false
        viewModel?.getArticles((viewModel?.numberOfArticle.value)! + 1)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.invalidateLayout()
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    
    init(layout: UICollectionViewLayout, viewModel: MainViewModelType) {
        super.init(collectionViewLayout: layout)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  


// MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems() ?? 0
    }

   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 16, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ArticleCell
    
        guard let collectionViewCell = cell, let viewModel = viewModel else { return UICollectionViewCell() }
    
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
        cellViewModel?.articleImage.bind {
            collectionViewCell.articleImage.image = $0
        }
        
        collectionViewCell.viewModel = cellViewModel
        
        return collectionViewCell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

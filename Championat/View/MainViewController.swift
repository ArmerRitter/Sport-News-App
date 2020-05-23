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
    var getNewPageFlag = false
    
    var viewModel: MainViewModelType?
    
    let titleImage: UIImageView = {
       let imageView = UIImageView()
       let image = UIImage(named: "logo8")
       imageView.contentMode = .scaleAspectFit
       imageView.image = image
       return imageView
    }()
    
    let updateButton: UIButton = {
       let button = UIButton()
       button.backgroundColor = .championatColor
       button.titleLabel?.font = .systemFont(ofSize: 14)
       button.layer.cornerRadius = 10
       button.isHidden = true
        button.alpha = 0.9
       button.translatesAutoresizingMaskIntoConstraints = false
       return button
    }()

//MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        setupView()
        
        
        
        collectionView.backgroundColor = .white
        
        //Demo button
        let newRecordButton: UIBarButtonItem = {
            let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
            
            return button
        }()
        
        
        navigationItem.rightBarButtonItem = newRecordButton
        
        // Register cell classes
        self.collectionView!.register(ArticleCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    @objc func add() {
        collectionView.reloadData()
        updateButton.isHidden = false
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        collectionView.contentOffset.y = -10
    }
    
    func setupView() {
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02745098039, green: 0.1333333333, blue: 0.2156862745, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.titleView = titleImage
        
        view.addSubview(updateButton)
        
        NSLayoutConstraint.activate([
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            updateButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            updateButton.widthAnchor.constraint(equalToConstant: 120),
            updateButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        updateButton.addTarget(self, action: #selector(tapOn), for: .touchUpInside)

    }
    
    func setupBinding() {
        viewModel?.numberOfPage.bind(listener: { [unowned self] number in
            self.collectionView.reloadData()
            self.getNewPageFlag = true
        })
        
        viewModel?.numberOfNewArticles.bind(listener: { [unowned self] number in
            if number > 0 {
            self.updateButton.isHidden = false
            self.updateButton.setTitle("Download +\(number)", for: .normal)
            } else {
            self.updateButton.isHidden = true
            }
        })
    }
    
    @objc func tapOn() {
        viewModel?.numberOfNewArticles.value = 0
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        collectionView.contentOffset.y = -10
       
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottom = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottom >= scrollView.contentSize.height - 400 && getNewPageFlag {
             getNewPageFlag = false
        viewModel?.getArticles((viewModel?.numberOfPage.value)! + 1)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.invalidateLayout()
    }
   
//MARK: Initialization
    
    init(layout: UICollectionViewLayout, viewModel: MainViewModelType) {
        super.init(collectionViewLayout: layout)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: UICollectionViewDataSource & Delegate

extension MainViewController {
    
   // DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems() ?? 0
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

    //Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailsViewModel = viewModel?.viewModelForSelectedArticle(forIndexPath: indexPath) else { return }
        
        let vc = DetailsViewController(viewModel: detailsViewModel)
        navigationController?.pushViewController(vc, animated: true)
    }

}

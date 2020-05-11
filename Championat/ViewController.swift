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

    var collectionView: UICollectionView!
    var layout = UICollectionViewFlowLayout()
    var customLayout = CustomLayout()
    var colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.yellow, UIColor.purple, UIColor.brown, UIColor.cyan, UIColor.gray, UIColor.footballColor, UIColor.hockeyColor, UIColor.lifeStyleColor, UIColor.basketballColor, UIColor.tennisColor, UIColor.cyberSportColor, UIColor.boxAndMMAColor]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //collectionView.backgroundColor = .clear
      
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: customLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
       // collectionView.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
        
        view.addSubview(collectionView)
       
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }

    
   
    
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
//    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 16, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colors[indexPath.item]
        cell.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.layer.shadowColor = UIColor.white.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      //  print("\(indexPath.item)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var atr = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: 0, section: 0))

       // collectionView.collectionViewLayout.invalidateLayout()
        
       //print(collectionView.contentOffset.y)
    }
    
}

class CustomLayout: UICollectionViewLayout {
    
    private var cacheAtributes = [UICollectionViewLayoutAttributes]()
    private var contentSize: CGSize = .zero
    
    
    override func prepare() {
        super.prepare()
        
        contentSize = .zero
        cacheAtributes.removeAll()
        
        guard let collectionView = collectionView else { return }
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            var itemFrame = CGRect(origin: CGPoint(x: 10, y: 90 * item + 10), size: CGSize(width: collectionView.bounds.width - 20, height: 80))
            
            let indexPath = IndexPath(item: item, section: 0)
            let atributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            
            let yOffset = collectionView.contentOffset.y + 88
            
            if itemFrame.origin.y <= yOffset + 10 {
                itemFrame.origin.y += yOffset - CGFloat(90 * item)
                atributes.alpha = 1
                //atributes.transform = .identity
            }
            
            var k = CGFloat(90 * (item)) / yOffset
            print(item, yOffset, k)
            
            if  itemFrame.origin.y <= yOffset + 90 && item > 0 && itemFrame.origin.y > yOffset + 10 {
              //r  atributes.alpha = 0.5
                atributes.transform = CGAffineTransform(translationX: 10 * 1, y: 0)
            } else {
                
            }
            
            atributes.frame = itemFrame
            
           // atributes.zIndex = 300
            
            cacheAtributes.append(atributes)
           }
        print()
        contentSize = CGSize(width: collectionView.bounds.width, height: CGFloat(90 * cacheAtributes.count))
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var atributeList = [UICollectionViewLayoutAttributes]()
        
        for atribute in cacheAtributes {
            if atribute.frame.intersects(rect) {
                atributeList.append(atribute)
            }
        }
        return atributeList
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        return cacheAtributes[indexPath.item]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

//
//  ArticleCollectionViewLayout.swift
//  Championat
//
//  Created by Yuriy Balabin on 11.05.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit


class ArticleCollectionViewLayout: UICollectionViewLayout {
    
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
            
            let yOffset = collectionView.contentOffset.y
            let cell = collectionView.cellForItem(at: indexPath) as? ArticleCell
            
            if itemFrame.origin.y <= yOffset + 10 {
                itemFrame.origin.y += yOffset - CGFloat(90 * item)
                }
            
            if  itemFrame.origin.y <= yOffset + 90 && item > 0 && itemFrame.origin.y > yOffset + 10 {
              
                atributes.transform = CGAffineTransform(translationX: -25, y: 0)
                
                let prevCell = collectionView.cellForItem(at: IndexPath(item: item - 1, section: 0)) as? ArticleCell
                prevCell?.backgroundColor = #colorLiteral(red: 0.9296875, green: 0.9296875, blue: 0.9296875, alpha: 1)
              
                cell?.layer.shadowOffset = CGSize(width: 10, height: -10)
                cell?.layer.shadowColor = UIColor.darkGray.cgColor
                cell?.layer.shadowPath = UIBezierPath(rect: cell!.bounds).cgPath
                cell?.layer.shadowOpacity = 0.8
                cell?.layer.shadowRadius = 10
                cell?.layer.masksToBounds = false
                
            } else {
                cell?.backgroundColor = .white
                cell?.layer.masksToBounds = true
            }
            
            atributes.frame = itemFrame
            cacheAtributes.append(atributes)
           }

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

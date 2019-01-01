//
//  MainViewCollectionLayoutManager.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/28.
//  Copyright © 2018 Brad. All rights reserved.
//

import UIKit
import SwifterSwift

class MainViewCollectionLayoutManager {
    
    weak var collectionView: UICollectionView?
    
    var layoutType: Preference.ViewByType
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.register(nibWithCellClass: FeedItemCell.self)
        self.collectionView?.register(nibWithCellClass: FeedDetailItemCell.self)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = CGSize(width: SwifterSwift.screenWidth, height: 100)
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        layoutType = Preference.viewByType
    }
    
    func switchLayout() {
        let desiredLayout = Preference.viewByType
        if layoutType == desiredLayout {
            return
        }
        layoutType = desiredLayout
        if desiredLayout == .row {
            collectionView?.setCollectionViewLayout(MainViewRowLayout(), animated: true)
        } else {
            collectionView?.setCollectionViewLayout(MainViewGridLayout(), animated: true)
        }
    }
}

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
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.register(nibWithCellClass: FeedItemCell.self)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = CGSize(width: SwifterSwift.screenWidth, height: 100)
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
    }
    
    
}

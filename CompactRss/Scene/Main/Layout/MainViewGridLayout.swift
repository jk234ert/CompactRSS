//
//  MainViewGridLayout.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/31.
//  Copyright © 2018 Brad. All rights reserved.
//

import UIKit
import SwifterSwift

class MainViewGridLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
//        estimatedItemSize = CGSize(width: SwifterSwift.screenWidth / 2.0, height: 100)
        itemSize = CGSize(width: SwifterSwift.screenWidth / 2.0, height: 200)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .vertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


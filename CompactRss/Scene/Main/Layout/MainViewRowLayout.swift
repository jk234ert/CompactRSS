//
//  MainViewRowLayout.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/31.
//  Copyright © 2018 Brad. All rights reserved.
//

import UIKit
import SwifterSwift

class MainViewRowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        estimatedItemSize = CGSize(width: SwifterSwift.screenWidth, height: 100)
        itemSize = UICollectionViewFlowLayout.automaticSize
        minimumInteritemSpacing = 0
        scrollDirection = .vertical
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

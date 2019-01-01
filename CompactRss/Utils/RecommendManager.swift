//
//  RecommendManager.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/28.
//  Copyright © 2018 Brad. All rights reserved.
//

import Foundation

class RecommendManager {
    
    static let shared = RecommendManager()
    
    lazy var recommends: [RecommendFeed] = {
        return PlistFiles.items.compactMap { RecommendFeed(from: $0) }
    }()
    
    
}

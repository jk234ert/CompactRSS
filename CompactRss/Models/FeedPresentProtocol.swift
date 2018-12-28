//
//  FeedPresentProtocol.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/28.
//  Copyright © 2018 Brad. All rights reserved.
//

import Foundation
import FeedKit

protocol FeedChannelProtocol {
    var title: String { get }
    var imageUrl: String? { get }
    var link: String { get }
}

protocol FeedItemProtocol {
    var itemTitle: String { get }
    var imageUrl: String? { get }
}

extension RSSFeedItem: FeedItemProtocol {
    var itemTitle: String {
        return title ?? ""
    }
    
    
    var imageUrl: String? {
        return nil
    }
}

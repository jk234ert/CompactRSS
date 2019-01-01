//
//  RecommendFeed.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/28.
//  Copyright © 2018 Brad. All rights reserved.
//

import Foundation

struct RecommendFeed {
    let channelTitle: String?
    let channelLink: String?
    let category: String?
    let description: String?
    
    init?(from dict: [String: Any]) {
        guard let title = dict["title"] as? String else {
            return nil
        }
        guard let link = dict["link"] as? String else {
            return nil
        }
        self.channelTitle = title
        self.channelLink = link
        if let category = dict["category"] as? String {
            self.category = category
        } else {
            self.category = nil
        }
        if let description = dict["description"] as? String {
            self.description = description
        } else {
            self.description = nil
        }
    }
}

extension RecommendFeed: FeedChannelProtocol {
    var pubDate: Date? {
        return nil
    }
    
    
    var imageUrl: String? {
        return nil
    }
    
    var feedItems: [FeedItemProtocol] {
        return []
    }
    
    func getItems() -> [FeedItemProtocol] {
        return []
    }
}

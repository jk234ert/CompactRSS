//
//  RecommendFeed.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/28.
//  Copyright © 2018 Brad. All rights reserved.
//

import Foundation

struct RecommendFeed {
    let title: String
    let link: String
    let category: String?
    let description: String?
    
    init?(from dict: [String: Any]) {
        guard let title = dict["title"] as? String else {
            return nil
        }
        guard let link = dict["link"] as? String else {
            return nil
        }
        self.title = title
        self.link = link
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
    var imageUrl: String? {
        return nil
    }
}

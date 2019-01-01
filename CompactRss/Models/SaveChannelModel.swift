//
//  SaveChannelModel.swift
//  CompactRss
//
//  Created by jk234ert on 2019/1/1.
//  Copyright © 2019 Brad. All rights reserved.
//

import Foundation

struct SaveChannelModel: FeedChannelProtocol, Codable {
    var channelTitle: String?
    var imageUrl: String?
    var channelLink: String?
    var pubDate: Date?
    
    func getItems() -> [FeedItemProtocol] {
        return []
    }
}

//struct SaveFeedItemModel: FeedItemProtocol, Codable {
//    var itemTitle: String
//    var imageUrl: String?
//    var pubDate: Date?
//    var description: String?
//    var link: String?
//}

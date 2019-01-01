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
    var channelTitle: String? { get }
    var imageUrl: String? { get }
    var channelLink: String? { get }
    var pubDate: Date? { get }
    
    var feedItems: [FeedItemProtocol] { get }
}

protocol FeedItemProtocol {
    var itemTitle: String { get }
    var imageUrl: String? { get }
    var pubDate: Date? { get }
    var description: String? { get }
}

extension RSSFeed: FeedChannelProtocol {
    var feedItems: [FeedItemProtocol] {
        return items ?? []
    }
    
    var channelTitle: String? {
        return title
    }
    
    var channelLink: String? {
        return link
    }
    
    var imageUrl: String? {
        return image?.link
    }
}

extension AtomFeed: FeedChannelProtocol {
    var pubDate: Date? {
        return updated
    }
    
    var channelTitle: String? {
        return title
    }
    
    var imageUrl: String? {
        return nil
    }
    
    var channelLink: String? {
        return links?.first?.attributes?.href ?? ""
    }
    
    var feedItems: [FeedItemProtocol] {
        return entries ?? []
    }
}

extension RSSFeedItem: FeedItemProtocol {
    var itemTitle: String {
        return title ?? ""
    }
    
    
    var imageUrl: String? {
        return nil
    }
}

extension AtomFeedEntry: FeedItemProtocol {
    var description: String? {
        return summary?.value ?? ""
    }
    
    var itemTitle: String {
        return title ?? ""
    }
    
    var imageUrl: String? {
        return nil
    }
    
    var pubDate: Date? {
        return published
    }
}

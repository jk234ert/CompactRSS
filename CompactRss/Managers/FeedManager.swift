//
//  FeedManager.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/28.
//  Copyright © 2018 Brad. All rights reserved.
//

import Foundation
import FeedKit
import PromiseKit

class FeedManager {
    
    private static let savedFeedPlistName = "channels"
    
    class func loadRecommendFeeds() {
        for recommend in RecommendManager.shared.recommends {
            if let validLink = recommend.channelLink, let feedUrl = URL(string: validLink) {
                let parser = FeedParser(URL: feedUrl)
                parser.parseAsync { (result) in
                    print("parsed")
                }
            }
        }
    }
    
    class func allChannels() -> [FeedChannelProtocol] {
        return RecommendManager.shared.recommends
    }
    
    class func fetchFeed(channel: FeedChannelProtocol) -> Promise<FeedChannelProtocol> {
        return Promise { seal in
            if let validLink = channel.channelLink, let feedUrl = URL(string: validLink) {
                let parser = FeedParser(URL: feedUrl)
                parser.parseAsync { (result) in
                    if let rssFeed = result.rssFeed {
                        seal.resolve(rssFeed, result.error)
                    } else if let atomFeed = result.atomFeed {
                        seal.resolve(atomFeed, result.error)
                    } else if let jsonFeed = result.jsonFeed {
                        
                    } else {
                        seal.reject(FeedMetaInfoError.invalidUrl(url: channel.channelLink ?? ""))
                    }
                }
            } else {
                seal.reject(FeedMetaInfoError.invalidUrl(url: channel.channelLink ?? ""))
            }
        }
    }
    
    class func fetchFeeds(channels: [FeedChannelProtocol]) -> [Promise<FeedChannelProtocol>] {
        return channels.map { fetchFeed(channel: $0) }
    }
}

extension FeedManager {
    class func loadSavedChannels() -> [FeedChannelProtocol] {
        guard let url = Bundle(for: FeedManager.self).url(forResource: savedFeedPlistName, withExtension: "plist") else {
            return []
        }
        if let list = NSArray(contentsOf: url) as? [FeedChannelProtocol] {
            return list
        } else {
            return []
        }
    }
    
    class func saveChannels(_ feeds: [FeedChannelProtocol]) {
        
    }
}

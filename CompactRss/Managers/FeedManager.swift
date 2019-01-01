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
    private static var savedChannelUrlString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appendingPathComponent("channels.json")
    
//    class func loadRecommendFeeds() {
//        for recommend in RecommendManager.shared.recommends {
//            if let validLink = recommend.channelLink, let feedUrl = URL(string: validLink) {
//                let parser = FeedParser(URL: feedUrl)
//                parser.parseAsync { (result) in
//                    print("parsed")
//                }
//            }
//        }
//    }
    
    class func allChannels() -> [FeedChannelProtocol] {
        var channels = [FeedChannelProtocol]()
        if Preference.firstTypeLaunch {
            // Save recommends to local file at first launch
            saveChannels(RecommendManager.shared.recommends)
            Preference.firstTypeLaunch = false
        }
        channels.append(contentsOf: loadSavedChannels())
        return channels
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
    
    class func fetchFeed(url: String) -> Promise<FeedChannelProtocol> {
        return Promise { seal in
            guard let validUrl = URL(string: url) else {
                seal.reject(FeedMetaInfoError.invalidUrl(url: url))
                return
            }
            let parser = FeedParser(URL: validUrl)
            parser.parseAsync { (result) in
                if result.isFailure {
                    seal.reject(result.error ?? FeedMetaInfoError.invalidUrl(url: url))
                }
                if let rssFeed = result.rssFeed {
                    seal.resolve(rssFeed, result.error)
                } else if let atomFeed = result.atomFeed {
                    seal.resolve(atomFeed, result.error)
                } else if let jsonFeed = result.jsonFeed {
                    
                } else {
                    seal.reject(FeedMetaInfoError.invalidUrl(url: url))
                }
            }
        }
    }
}

extension FeedManager {
    class func loadSavedChannels() -> [FeedChannelProtocol] {
        do {
            let url = URL(fileURLWithPath: savedChannelUrlString)
            let savedChannels = try JSONDecoder().decode([SaveChannelModel].self, from: Data(contentsOf: url))
            return savedChannels
        } catch let error {
            logger.error("Fail to load channels, error: \(error.localizedDescription)")
            return []
        }
    }
    
    class func saveChannels(_ feeds: [FeedChannelProtocol]) {
        let toSaveChannels = feeds.map { SaveChannelModel(channelTitle: $0.channelTitle,
                                                          imageUrl: $0.imageUrl,
                                                          channelLink: $0.channelLink,
                                                          pubDate: $0.pubDate) }
        do {
            let url = URL(fileURLWithPath: savedChannelUrlString)
            try JSONEncoder().encode(toSaveChannels).write(to: url)
        } catch let error {
            logger.error("Fail to save channels, error: \(error.localizedDescription)")
        }
        
    }
}

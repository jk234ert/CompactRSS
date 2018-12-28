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
    class func loadRecommendFeeds() {
        for recommend in RecommendManager.shared.recommends {
            if let feedUrl = URL(string: recommend.link) {
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
    
    class func fetchFeeds(channels: [FeedChannelProtocol]) -> Promise<[FeedItemProtocol]> {
        
        return Promise { seal in
            for channel in channels {
                if let feedUrl = URL(string: channel.link) {
                    let parser = FeedParser(URL: feedUrl)
                    parser.parseAsync { (result) in
                        if let rssFeed = result.rssFeed {
                            seal.resolve(rssFeed.items ?? [], result.error)
                        } else {
                            
                        }
                    }
                } else {
                    seal.reject(FeedMetaInfoError.invalidUrl(url: channel.link))
                }
            }
        }
    }
}

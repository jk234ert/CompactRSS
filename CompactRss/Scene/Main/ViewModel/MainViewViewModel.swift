//
//  MainViewViewModel.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/28.
//  Copyright © 2018 Brad. All rights reserved.
//

import UIKit
import SwifterSwift
import PromiseKit

class MainViewViewModel: NSObject {
    
    enum DisplayMode {
        case byChannel, byTime
        
        func getSectionCount(feeds: [FeedChannelProtocol]) -> Int {
            switch self {
            case .byChannel:
                return feeds.count
            case .byTime:
                return 1
            }
        }
        
        func getNumberOfItemsInSection(feeds: [FeedChannelProtocol], section: Int) -> Int {
            switch self {
            case .byChannel:
                return feeds[section].feedItems.count
            case .byTime:
                return 1
            }
        }
        
        func getFeedChannel(feeds: [FeedChannelProtocol], section: Int) -> FeedChannelProtocol {
            return feeds[section]
        }
        
        func getFeedItem(feeds: [FeedChannelProtocol],
                         indexPath: IndexPath) -> FeedItemProtocol {
            return feeds[indexPath.section].feedItems[indexPath.row]
        }
    }
    
    var feeds: [FeedChannelProtocol] = [FeedChannelProtocol]()
    
    var feedItems: [FeedItemProtocol] = [FeedItemProtocol]()
    
    var displayMode: DisplayMode = .byChannel
    
    var layoutManager: MainViewCollectionLayoutManager?
   
    init(collectionView: UICollectionView) {
        layoutManager = MainViewCollectionLayoutManager(collectionView: collectionView)
        
    }
    
    func loadLatestFeeds() {
        let channels = FeedManager.allChannels()
        when(resolved: FeedManager.fetchFeeds(channels: channels))
            .done(on: DispatchQueue.main)  { [weak self] (results) in
                for result in results {
                    switch result {
                    case .rejected(let error):
                        logger.error("Fail to fetch feed, error: \(error.localizedDescription)")
                    case .fulfilled(let channel):
                        self?.feeds.append(channel)
                    }
                }
                self?.feeds.sort(by: { (channel1, channel2) -> Bool in
                    return channel1.pubDate ?> channel2.pubDate
                })
                self?.layoutManager?.collectionView?.reloadData()
            }
            .catch { error in
                logger.error("Fail to fetch feeds, underlay error: \(error.localizedDescription)")
        }
    }
    
    func sortData() {
        
    }
    
    func switchLayout() {
        layoutManager?.switchLayout()
    }
}

extension MainViewViewModel: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return displayMode.getSectionCount(feeds: feeds)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayMode.getNumberOfItemsInSection(feeds: feeds, section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: FeedDetailItemCell.self, for: indexPath)
        let feedItem = displayMode.getFeedItem(feeds: feeds, indexPath: indexPath)
        let channel = displayMode.getFeedChannel(feeds: feeds, section: indexPath.section)
        cell.feedItem = feedItem
        cell.channelTitleLabel.text = "#" + (channel.channelTitle ?? "")
        return cell
    }
}

extension MainViewViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SwifterSwift.screenWidth, height: 0.1)
    }
}

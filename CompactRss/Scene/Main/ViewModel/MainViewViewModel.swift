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
import KafkaRefresh

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
                return feeds[section].getItems().count
            case .byTime:
                return 1
            }
        }
        
        func getFeedChannel(feeds: [FeedChannelProtocol], section: Int) -> FeedChannelProtocol {
            return feeds[section]
        }
        
        func getFeedItem(feeds: [FeedChannelProtocol],
                         indexPath: IndexPath) -> FeedItemProtocol {
            return feeds[indexPath.section].getItems()[indexPath.row]
        }
    }
    
    var feeds: [FeedChannelProtocol] = [FeedChannelProtocol]()
    
    var feedItems: [FeedItemProtocol] = [FeedItemProtocol]()
    
    var displayMode: DisplayMode = .byChannel
    
    var layoutManager: MainViewCollectionLayoutManager?
    
    var needRefresh: Bool = true
    
    weak var viewController: UIViewController?
   
    init(collectionView: UICollectionView, viewController: UIViewController) {
        layoutManager = MainViewCollectionLayoutManager(collectionView: collectionView)
        super.init()
        self.viewController = viewController
        collectionView.bindHeadRefreshHandler({ [weak self] in
            self?.loadLatestFeeds()
        }, themeColor: .gray, refreshStyle: .replicatorWoody)
    }
    
    func loadLatestFeeds() {
        let channels = FeedManager.allChannels()
        layoutManager?.collectionView?.headRefreshControl.beginRefreshing()
        when(resolved: FeedManager.fetchFeeds(channels: channels))
            .done(on: DispatchQueue.main)  { [weak self] (results) in
                self?.feeds.removeAll()
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
            }.ensure(on: DispatchQueue.main) { [weak self] in
                self?.layoutManager?.collectionView?.headRefreshControl.endRefreshing()
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
    
    func refreshIfNeeded() {
        if feeds.count != FeedManager.allChannels().count {
            loadLatestFeeds()
        }
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
    
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        collectionView.cellForItem(at: indexPath)?.backgroundColor = .red
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        collectionView.cellForItem(at: indexPath)?.backgroundColor = .purple
//    }
//
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let feedItem = displayMode.getFeedItem(feeds: feeds, indexPath: indexPath)
        let channel = displayMode.getFeedChannel(feeds: feeds, section: indexPath.section)
        let vc = FeedDetailViewController()
        vc.url = feedItem.itemLink
        vc.title = channel.channelTitle
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

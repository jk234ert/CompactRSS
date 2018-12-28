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
    
    var feeds: [FeedItemProtocol] = [FeedItemProtocol]()
    
    var layoutManager: MainViewCollectionLayoutManager?
   
    init(collectionView: UICollectionView) {
        layoutManager = MainViewCollectionLayoutManager(collectionView: collectionView)
        
    }
    
    func loadLatestFeeds() {
        let channels = FeedManager.allChannels()
        firstly {
            FeedManager.fetchFeeds(channels: channels)
            }.done(on: DispatchQueue.main) { [weak self] (items) in
                self?.feeds.append(contentsOf: items)
                self?.layoutManager?.collectionView?.reloadData()
            }.catch { (error) in
                logger.error("Fail to fetch feeds, underlay error: \(error.localizedDescription)")
        }
    }
}

extension MainViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: FeedItemCell.self, for: indexPath)
        cell.feedItem = feeds[indexPath.row]
        return cell
    }
}

extension MainViewViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SwifterSwift.screenWidth, height: 0.1)
    }
}

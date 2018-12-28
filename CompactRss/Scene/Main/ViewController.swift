//
//  ViewController.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/27.
//  Copyright © 2018 Brad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var feedsCollectionView: UICollectionView!
    
    var viewModel: MainViewViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewViewModel(collectionView: feedsCollectionView)
        feedsCollectionView.dataSource = viewModel
        feedsCollectionView.delegate = viewModel
        
        viewModel?.loadLatestFeeds()
    }


}


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
        setSettingBarButtonItem()
        viewModel = MainViewViewModel(collectionView: feedsCollectionView, viewController: self)
        feedsCollectionView.dataSource = viewModel
        feedsCollectionView.delegate = viewModel
        
        viewModel?.loadLatestFeeds()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.refreshIfNeeded()
    }

    private func setSettingBarButtonItem() {
        //Not implemented
//        let settingBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showMainSetting(sender:)))
//        navigationItem.leftBarButtonItem = settingBarButtonItem
        
        let manageBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showChannelManageView(sender:)))
        navigationItem.rightBarButtonItem = manageBarButtonItem
    }
    
    @objc
    private func showChannelManageView(sender: UIBarButtonItem) {
        let vc = ChannelManageViewController()
        navigationController?.pushViewController(vc)
    }
    
    @objc
    private func showMainSetting(sender: UIBarButtonItem) {
        let vc = SettingPopoverViewController.init(nibName: "SettingPopoverViewController", bundle: nil)
        vc.delegate = self
        vc.present(in: self, byBarButtonItem: sender, delegate: self)
    }

}

extension ViewController: SettingPopoverDelegate {
    func settingPopoverValueDidChange(_ viewController: SettingPopoverViewController, sortByChangedTo type: Preference.SortType) {
        
    }
    
    func settingPopoverValueDidChange(_ viewController: SettingPopoverViewController, viewByChangedTo type: Preference.ViewByType) {
//        viewModel?.switchLayout()
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}


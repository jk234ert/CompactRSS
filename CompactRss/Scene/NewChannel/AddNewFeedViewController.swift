//
//  AddNewFeedViewController.swift
//  CompactRss
//
//  Created by jk234ert on 2019/1/1.
//  Copyright © 2019 Brad. All rights reserved.
//

import UIKit
import PromiseKit

class AddNewFeedViewController: UIViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    var addedNewChannelBlock: ((FeedChannelProtocol) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Channel"
        urlTextField.delegate = self
        searchButton.addTarget(self, action: #selector(searchButtonDidClicked(_:)), for: .touchUpInside)
    }

    @objc
    private func searchButtonDidClicked(_ sender: UIButton) {
        searchForChannel()
    }
    
    private func searchForChannel() {
        guard let inputUrlString = urlTextField.text else { return }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        HUD.showLoading()
        firstly {
            FeedManager.fetchFeed(url: inputUrlString)
            }.done(on: DispatchQueue.main) { [weak self] (channel) in
                self?.showAddNewChannelAlert(channel: channel, url: inputUrlString)
                HUD.hide()
            }.ensure(on: DispatchQueue.main) {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }.catch(on: DispatchQueue.main) { (error) in
                HUD.showError(error.localizedDescription)
        }
    }
    
    private func showAddNewChannelAlert(channel: FeedChannelProtocol, url: String) {
        let newChannelModel = SaveChannelModel(channelTitle: channel.channelTitle,
                                               imageUrl: channel.imageUrl,
                                               channelLink: url,
                                               pubDate: channel.pubDate)
        addedNewChannelBlock?(newChannelModel)
        navigationController?.popViewController(animated: true)
    }
}

extension AddNewFeedViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchForChannel()
        return true
    }
}

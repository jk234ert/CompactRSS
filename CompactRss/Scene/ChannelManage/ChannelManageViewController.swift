//
//  ChannelManageViewController.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/31.
//  Copyright © 2018 Brad. All rights reserved.
//

import UIKit
import TinyConstraints

class ChannelManageViewController: BaseUIViewController {
    
    private var tableView: UITableView?
    
    private var viewModel: ChannelManagerViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed Channels"
        tableView = UITableView(frame: .zero)
        view.addSubview(tableView!)
        tableView?.edgesToSuperview()
        viewModel = ChannelManagerViewModel(tableView: tableView!)
        
        setAddChannelBarButtonItem()
    }
    
    private func setAddChannelBarButtonItem() {
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonItemClicked(sender:)))
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    @objc
    private func addBarButtonItemClicked(sender: UIBarButtonItem) {
        let vc = AddNewFeedViewController.init(nibName: "AddNewFeedViewController", bundle: nil)
        vc.addedNewChannelBlock = { channel in
            self.viewModel?.addNewChannel(channel)
        }
        navigationController?.pushViewController(vc)
    }
}

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
        tableView = UITableView(frame: .zero)
        view.addSubview(tableView!)
        tableView?.edgesToSuperview()
        viewModel = ChannelManagerViewModel(tableView: tableView!)
        
    }
}

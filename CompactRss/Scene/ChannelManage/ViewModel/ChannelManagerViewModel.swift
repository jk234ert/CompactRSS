//
//  ChannelManagerViewModel.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/31.
//  Copyright © 2018 Brad. All rights reserved.
//

import UIKit

class ChannelManagerViewModel: NSObject {
    
    private let channelCellIdentifier = "channelListCellIdentifier"
    
    enum ChannelManageSection {
        case newChannel, channelList
        
        var title: String? {
            switch self {
            case .newChannel:
                return "New Feed"
            case .channelList:
                return "Added Feeds"
            }
        }
        
        var cellCount: Int {
            switch self {
            case .newChannel:
                return 1
            case .channelList:
                return 10
            }
        }
    }
    
    var sections: [ChannelManageSection] = [.newChannel, .channelList]
    
    init(tableView: UITableView) {
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ChannelManagerViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if sections[indexPath.section] == .newChannel {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "addNewChannelCell")
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = "Add new feed"
            return cell
        } else {
            var cell: UITableViewCell?
            cell = tableView.dequeueReusableCell(withIdentifier: channelCellIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: channelCellIdentifier)
            }
            cell?.textLabel?.text = "Channel"
            return cell!
        }
    }
}

extension ChannelManagerViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == 0 {
            return .none
        }
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


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
    
//    enum ChannelManageSection {
//        case newChannel, channelList
//
//        var title: String? {
//            switch self {
//            case .newChannel:
//                return "New Feed"
//            case .channelList:
//                return "Added Feeds"
//            }
//        }
//
//        var cellCount: Int {
//            switch self {
//            case .newChannel:
//                return 1
//            case .channelList:
//                return 10
//            }
//        }
//    }
    weak var tableView: UITableView?
    var channels: [FeedChannelProtocol] = [FeedChannelProtocol]()
    
    init(tableView: UITableView) {
        super.init()
        channels = FeedManager.allChannels()
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.setEditing(true, animated: false)
    }
    
    func addNewChannel(_ channel: FeedChannelProtocol) {
        channels.append(channel)
        FeedManager.saveChannels(channels)
        tableView?.reloadData()
    }
}

extension ChannelManagerViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        cell = tableView.dequeueReusableCell(withIdentifier: channelCellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: channelCellIdentifier)
        }
        cell?.textLabel?.text = channels[indexPath.row].channelTitle
        return cell!
    }
}

extension ChannelManagerViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        channels.remove(at: indexPath.row)
        FeedManager.saveChannels(channels)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


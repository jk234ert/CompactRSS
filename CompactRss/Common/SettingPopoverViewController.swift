//
//  SettingPopoverViewController.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/31.
//  Copyright © 2018 Brad. All rights reserved.
//

import UIKit

protocol SettingPopoverDelegate: class {
    func settingPopoverValueDidChange(_ viewController: SettingPopoverViewController, sortByChangedTo type: Preference.SortType)
    func settingPopoverValueDidChange(_ viewController: SettingPopoverViewController, viewByChangedTo type: Preference.ViewByType)
}

class SettingPopoverViewController: BaseUIViewController {
    
    let popoverSize = CGSize(width: 242, height: 40.5)
    
    @IBOutlet weak var sortBySegment: UISegmentedControl!
    
    @IBOutlet weak var viewBySegment: UISegmentedControl!
    
    weak var delegate: SettingPopoverDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .popover
        preferredContentSize = popoverSize
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
//        modalPresentationStyle = .popover
//        preferredContentSize = popoverSize
        
        if Preference.sortType == .channel {
            sortBySegment.selectedSegmentIndex = 0
        } else {
            sortBySegment.selectedSegmentIndex = 1
        }
        
        if Preference.viewByType == .row {
            viewBySegment.selectedSegmentIndex = 0
        } else {
            viewBySegment.selectedSegmentIndex = 1
        }
        
        sortBySegment.addTarget(self, action: #selector(segmentDidChanged(sender:)), for: .valueChanged)
        viewBySegment.addTarget(self, action: #selector(segmentDidChanged(sender:)), for: .valueChanged)
    }
    
    func present(in inViewController: UIViewController,
                 byBarButtonItem: UIBarButtonItem,
                 delegate: UIPopoverPresentationControllerDelegate? = nil) {
        guard let popoverVC = popoverPresentationController else { return }
        //        popoverVC.sourceView = sourceView
        //        popoverVC.sourceRect = sourceView.bounds
        popoverVC.delegate = delegate
        popoverVC.barButtonItem = byBarButtonItem
        
        inViewController.present(self, animated: true, completion: nil)
    }
    
    @objc
    private func segmentDidChanged(sender: UISegmentedControl) {
        if sender == sortBySegment {
            Preference.sortType = Preference.SortType(rawValue: sender.selectedSegmentIndex)!
            delegate?.settingPopoverValueDidChange(self, sortByChangedTo: Preference.SortType(rawValue: sender.selectedSegmentIndex)!)
        } else {
            Preference.viewByType = Preference.ViewByType(rawValue: sender.selectedSegmentIndex)!
            delegate?.settingPopoverValueDidChange(self, viewByChangedTo: Preference.ViewByType(rawValue: sender.selectedSegmentIndex)!)
        }
    }
}

//
//  FeedDetailViewController.swift
//  CompactRss
//
//  Created by jk234ert on 2019/1/1.
//  Copyright © 2019 Brad. All rights reserved.
//

import UIKit
import WebKit
import TinyConstraints

class FeedDetailViewController: BaseUIViewController {
    
    private var wkWebView: WKWebView?
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wkWebView = WKWebView(frame: .zero)
        view.addSubview(wkWebView!)
        wkWebView?.edgesToSuperview()
        
        if let validUrl = url, let request = URLRequest(urlString: validUrl) {
            wkWebView?.load(request)
        }
    }
}

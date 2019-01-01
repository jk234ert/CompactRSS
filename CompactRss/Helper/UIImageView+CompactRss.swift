//
//  UIImageView+CompactRss.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/31.
//  Copyright © 2018 Brad. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(_ url: URL, placeholderImage placeholder: UIImage? = nil) {
        var opts = KingfisherOptionsInfo()
        opts.append(.transition(.fade(0.5)))
        self.kf.setImage(with: url, placeholder: placeholder, options: opts)
    }
    
    func setImage(_ urlString: String?, placeholderImage placeholder: UIImage? = nil) {
        guard let url = urlString, let validUrl = URL(string: url) else {
            logger.error("invalid image url: \(urlString ?? "nil")")
            self.kf.cancelDownloadTask()
            self.image = placeholder
            return
        }
        setImage(validUrl, placeholderImage: placeholder)
    }
}

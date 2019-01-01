//
//  Error.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/28.
//  Copyright © 2018 Brad. All rights reserved.
//

import Foundation

enum FeedMetaInfoError: Error {
    case invalidUrl(url: String)
}

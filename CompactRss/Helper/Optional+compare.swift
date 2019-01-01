//
//  Optional+compare.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/31.
//  Copyright © 2018 Brad. All rights reserved.
//

import Foundation

precedencegroup ComparePrecedence {
    associativity: none
    higherThan: MultiplicationPrecedence
}

infix operator ?<: ComparePrecedence

infix operator ?>: ComparePrecedence

func ?< <L: Comparable>(left: Optional<L>, right: Optional<L>) -> Bool {
    switch (left, right) {
    case (.none, .none):
        return true
    case (.none, .some):
        return false
    case (.some, .none):
        return true
    case (.some(let date1), .some(let date2)):
        return date1 < date2
    }
}

func ?> <L: Comparable>(left: Optional<L>, right: Optional<L>) -> Bool {
    switch (left, right) {
    case (.none, .none):
        return true
    case (.none, .some):
        return false
    case (.some, .none):
        return true
    case (.some(let date1), .some(let date2)):
        return date1 > date2
    }
}

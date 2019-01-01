//
//  Preference.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/31.
//  Copyright © 2018 Brad. All rights reserved.
//

import Foundation

extension UserDefaults {
    subscript<T: RawRepresentable>(key: String) -> T? {
        get {
            if let rawValue = value(forKey: key) as? T.RawValue {
                return T(rawValue: rawValue)
            }
            return nil
        }
        set { set(newValue?.rawValue, forKey: key) }
    }
    
    subscript<T>(key: String) -> T? {
        get { return value(forKey: key) as? T }
        set { set(newValue, forKey: key) }
    }
}

struct Preference {
    enum SortType: Int {
        case channel
        case time
    }
    
    enum ViewByType: Int {
        case row
        case grid
    }
    
    static var sortType: SortType {
        get { return UserDefaults.standard[#function] ?? .channel }
        set { UserDefaults.standard[#function] = newValue }
    }
    
    static var viewByType: ViewByType {
        get { return UserDefaults.standard[#function] ?? .row }
        set { UserDefaults.standard[#function] = newValue }
    }
}

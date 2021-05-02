//
//  CheckItem.swift
//  Domain
//
//  Created by akio0911 on 2021/05/02.
//

import Foundation

public struct CheckItem {
    public init(name: String, isChecked: Bool) {
        self.name = name
        self.isChecked = isChecked
    }

    public var name: String
    public var isChecked: Bool
}

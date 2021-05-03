//
//  CheckItem.swift
//  Domain
//
//  Created by akio0911 on 2021/05/02.
//

// Entity は他の VIPER モジュールに依存してはならない
import Foundation

public struct CheckItemID: RawRepresentable {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct CheckItem {
    public var id: CheckItemID
    public var name: String
    public var isChecked: Bool

    public init(id: CheckItemID, name: String, isChecked: Bool) {
        self.id = id
        self.name = name
        self.isChecked = isChecked
    }
}

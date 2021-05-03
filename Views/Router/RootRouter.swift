//
//  RootRouter.swift
//  Views
//
//  Created by akio0911 on 2021/05/02.
//

import UIKit

public class RootRouter {
    public init() {}

    public func presentCheckItemListScreen(in window: UIWindow) {
        window.rootViewController = CheckItemListRouter.assembleModule()
        window.makeKeyAndVisible()
    }
}

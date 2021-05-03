//
//  CheckItemAddRouter.swift
//  Views
//
//  Created by akio0911 on 2021/05/03.
//

import UIKit
import Presenter

public class CheckItemAddRouter {
    private weak var viewController: UIViewController?

    static func assembleModule() -> UIViewController {
        let router = CheckItemAddRouter()
        let presenter = CheckItemAddPresenter(router: router)
        let view = CheckItemAddViewController(presenter: presenter)

        router.viewController = view

        return view
    }
}

extension CheckItemAddRouter: CheckItemAddWireframe {
    public func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}

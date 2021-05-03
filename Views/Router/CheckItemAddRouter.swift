//
//  CheckItemAddRouter.swift
//  Views
//
//  Created by akio0911 on 2021/05/03.
//

import UIKit
import Infra
import Domain
import Presenter

public class CheckItemAddRouter {
    private weak var viewController: UIViewController?

    private var onDismissHandler: () -> Void = {}

    static func assembleModule(onDismissHandler: @escaping () -> Void) -> UIViewController {
        let repository = CheckItemRepository()
        let interactor = CheckItemAddInteractor(repository: repository)
        let router = CheckItemAddRouter()
        let presenter = CheckItemAddPresenter(
            interactor: interactor,
            router: router
        )
        let view = CheckItemAddViewController(presenter: presenter)

        interactor.output = presenter
        presenter.view = view

        router.viewController = view

        router.onDismissHandler = onDismissHandler

        return view
    }
}

extension CheckItemAddRouter: CheckItemAddWireframe {
    public func dismiss() {
        onDismissHandler()
        viewController?.dismiss(animated: true, completion: nil)
    }
}

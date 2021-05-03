//
//  CheckItemAddPresenter.swift
//  Presenter
//
//  Created by akio0911 on 2021/05/03.
//

import Foundation

public protocol CheckItemAddPresenterInput {
    func didTapAddButton()
    func didTapCancelButton()
}

public protocol CheckItemAddViewInterface: class {
}

public protocol CheckItemAddWireframe {
    func dismiss()
}

public class CheckItemAddPresenter {
    public weak var view: CheckItemAddViewInterface?

    private let router: CheckItemAddWireframe

    public init(router: CheckItemAddWireframe) {
        self.router = router
    }
}

extension CheckItemAddPresenter: CheckItemAddPresenterInput {
    public func didTapAddButton() {
        router.dismiss()
    }

    public func didTapCancelButton() {
        router.dismiss()
    }
}

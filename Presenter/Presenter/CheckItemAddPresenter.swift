//
//  CheckItemAddPresenter.swift
//  Presenter
//
//  Created by akio0911 on 2021/05/03.
//

import Foundation

public protocol CheckItemAddPresenterInput {
    func didChangeNameTextField(name: String)
    func didTapAddButton(name: String)
    func didTapCancelButton()
}

public protocol CheckItemAddViewInterface: class {
    func enableSaveButton(isEnabled: Bool)
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
    public func didChangeNameTextField(name: String) {
        view?.enableSaveButton(isEnabled: !name.isEmpty)
    }

    public func didTapAddButton(name: String) {
        router.dismiss()
    }

    public func didTapCancelButton() {
        router.dismiss()
    }
}

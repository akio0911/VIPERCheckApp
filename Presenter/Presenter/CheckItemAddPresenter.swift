//
//  CheckItemAddPresenter.swift
//  Presenter
//
//  Created by akio0911 on 2021/05/03.
//

import Domain

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

    private let interactor: CheckItemAddInteractorInput!

    private let router: CheckItemAddWireframe

    public init(interactor: CheckItemAddInteractorInput,
                router: CheckItemAddWireframe) {
        self.interactor = interactor
        self.router = router
    }
}

extension CheckItemAddPresenter: CheckItemAddPresenterInput {
    public func didChangeNameTextField(name: String) {
        view?.enableSaveButton(isEnabled: !name.isEmpty)
    }

    public func didTapAddButton(name: String) {
        interactor.add(name: name)
    }

    public func didTapCancelButton() {
        router.dismiss()
    }
}

extension CheckItemAddPresenter: CheckItemAddInteractorOutput {
    public func didCreated(result: Result<Void, CheckItemAddInteractorError>) {
        switch result {
        case .success:
            router.dismiss()
        case .failure:
            router.dismiss()
        }
    }
}

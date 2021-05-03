//
//  CheckItemListPresenter.swift
//  Views
//
//  Created by akio0911 on 2021/05/02.
//

// Presenter は Domain にのみ依存する
import Domain

public protocol CheckItemListPresenterInput {
    func updateView()
    func didTapAddButton()
    func reload()
}

public protocol CheckItemListViewInterface: class {
    func showCheckItems(checkItems: [CheckItem])
    func showErrorScreen()
    func showNoContentScreen()
}

public protocol CheckItemListWireframe {
    func presentAddScreen()
}

public class CheckItemListPresenter {
    public weak var view: CheckItemListViewInterface?

    private let interactor: CheckItemListInteractorInput!

    private let router: CheckItemListWireframe

    public init(interactor: CheckItemListInteractorInput,
                router: CheckItemListWireframe) {
        self.interactor = interactor
        self.router = router
    }
}

extension CheckItemListPresenter: CheckItemListPresenterInput {
    public func updateView() {
        interactor.fetchCheckItems()
    }

    public func didTapAddButton() {
        router.presentAddScreen()
    }

    public func reload() {
        interactor.fetchCheckItems()
    }
}

extension CheckItemListPresenter: CheckItemListInteractorOutput {
    public func didFetched(result: Result<[CheckItem], CheckItemListInteractorError>) {
        switch result {
        case .success(let checkItems):
            if checkItems.isEmpty {
                view?.showNoContentScreen()
            } else {
                view?.showCheckItems(checkItems: checkItems)
            }
        case .failure:
            view?.showErrorScreen()
        }
    }
}

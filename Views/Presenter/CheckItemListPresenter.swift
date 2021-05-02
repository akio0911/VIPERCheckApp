//
//  CheckItemListPresenter.swift
//  Views
//
//  Created by akio0911 on 2021/05/02.
//

import Domain

public protocol CheckItemListPresenterInput {
    func updateView()
}

public protocol CheckItemListViewInterface: class {
    func showCheckItems(checkItems: [CheckItem])
    func showErrorScreen()
    func showNoContentScreen()
}

public class CheckItemListPresenter {
    public weak var view: CheckItemListViewInterface?

    private let interactor: CheckItemListInteractorInput!

    public init(interactor: CheckItemListInteractorInput) {
        self.interactor = interactor
    }
}

extension CheckItemListPresenter: CheckItemListPresenterInput {
    public func updateView() {
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

//
//  CheckItemListRouter.swift
//  Views
//
//  Created by akio0911 on 2021/05/03.
//

import UIKit

// Router は DI を行う必要があるため、Infra, Domain, Presenter に依存する
import Infra
import Domain
import Presenter

public class CheckItemListRouter {
    private weak var checkItemListViewController: CheckItemListViewController?

    static func assembleModule() -> UIViewController {
        let repository = CheckItemRepository()
//        let repository = FakeRepository()
        let interactor = CheckItemListInteractor(repository: repository)
        let router = CheckItemListRouter()
        let presenter = CheckItemListPresenter(
            interactor: interactor,
            router: router
        )

        // ViewController は public ではないため、Router からのみインスタンス化できる
        let view = CheckItemListViewController(presenter: presenter)

        let navigation = UINavigationController(rootViewController: view)

        interactor.output = presenter
        presenter.view = view

        router.checkItemListViewController = view

        return navigation
    }
}

extension CheckItemListRouter: CheckItemListWireframe {
    public func presentAddScreen() {
        let checkItemAddViewController = CheckItemAddRouter.assembleModule(onDismissHandler: { [weak self] in

            self?.checkItemListViewController?.reload()
        })

        let nav = UINavigationController(
            rootViewController: checkItemAddViewController
        )

        nav.modalPresentationStyle = .fullScreen

        checkItemListViewController?.present(
            nav,
            animated: true,
            completion: nil
        )
    }
}

private struct FakeRepository: CheckItemRepositoryProtocol {
    func fetch(completion: @escaping (Result<[CheckItem], CheckItemRepositoryError>) -> Void) {

        let checkItems = [
            CheckItem(
                id: CheckItemID(rawValue: 1),
                name: "hello",
                isChecked: true
            )
        ]

        completion(.success(checkItems))
    }

    public func create(name: String, completion: @escaping (Result<Void, CheckItemRepositoryError>) -> Void) {

        completion(.failure(.unknown))
    }
}

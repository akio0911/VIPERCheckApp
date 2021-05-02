//
//  RootRouter.swift
//  Views
//
//  Created by akio0911 on 2021/05/02.
//

import UIKit
import Infra
import Domain

public class RootRouter {
    public init() {}

    public func presentCheckItemListScreen(in window: UIWindow) {
        window.rootViewController = CheckItemListRouter.assembleModule()
        window.makeKeyAndVisible()
    }
}

public class CheckItemListRouter {
    static func assembleModule() -> UIViewController {
//        let repository = CheckItemRepository()
        let repository = FakeRepository()
        let interactor = CheckItemListInteractor(repository: repository)
        let presenter = CheckItemListPresenter(interactor: interactor)
        let view = CheckItemListViewController(presenter: presenter)

        let navigation = UINavigationController(rootViewController: view)

        interactor.output = presenter
        presenter.view = view

        return navigation
    }
}

private struct FakeRepository: CheckItemRepositoryProtocol {
    func fetch(completion: @escaping (Result<[CheckItem], CheckItemRepositoryError>) -> Void) {

        completion(.success([CheckItem(name: "hello", isChecked: true)]))
    }


}

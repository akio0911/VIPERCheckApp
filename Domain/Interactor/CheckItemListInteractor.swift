//
//  CheckItemListInteractor.swift
//  Domain
//
//  Created by akio0911 on 2021/05/02.
//

// Interactor は他の VIPER モジュールに依存してはならない
import Foundation

public protocol CheckItemListInteractorInput {
    func fetchCheckItems()
}

public enum CheckItemListInteractorError: Error {
    case repositoryError
    case unknown
}

private extension CheckItemListInteractorError {
    init(repositoryError: CheckItemRepositoryError) {
        switch repositoryError {
        case .unknown:
            self = .unknown
        case .decodingError:
            self = .repositoryError
        }
    }
}

public protocol CheckItemListInteractorOutput: class {
    func didFetched(result: Result<[CheckItem], CheckItemListInteractorError>)
}

public enum CheckItemRepositoryError: Error {
    case decodingError
    case unknown
}

public protocol CheckItemRepositoryProtocol {
    func fetch(completion: @escaping (Result<[CheckItem], CheckItemRepositoryError>) -> Void)
}

public final class CheckItemListInteractor {
    public weak var output: CheckItemListInteractorOutput?
    private let repository: CheckItemRepositoryProtocol

    public init(repository: CheckItemRepositoryProtocol) {
        self.repository = repository
    }
}

extension CheckItemListInteractor: CheckItemListInteractorInput {
    public func fetchCheckItems() {
        repository.fetch(completion: { [weak self] in
            self?.output?.didFetched(
                result: $0.mapError { CheckItemListInteractorError(repositoryError: $0) }
            )
        })
    }
}

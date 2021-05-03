//
//  CheckItemAddInteractor.swift
//  Domain
//
//  Created by akio0911 on 2021/05/03.
//

import Foundation

public protocol CheckItemAddInteractorInput {
    func add(name: String)
}

public enum CheckItemAddInteractorError: Error {
    case repositoryError
    case unknown
}

private extension CheckItemAddInteractorError {
    init(repositoryError: CheckItemRepositoryError) {
        switch repositoryError {
        case .unknown:
            self = .unknown
        case .decodingError:
            self = .repositoryError
        }
    }
}

public protocol CheckItemAddInteractorOutput: class {
    func didCreated(result: Result<Void, CheckItemAddInteractorError>)
}

public final class CheckItemAddInteractor {
    public weak var output: CheckItemAddInteractorOutput?
    private let repository: CheckItemRepositoryProtocol

    public init(repository: CheckItemRepositoryProtocol) {
        self.repository = repository
    }
}

extension CheckItemAddInteractor: CheckItemAddInteractorInput {
    public func add(name: String) {
        repository.create(name: name, completion: { [weak self] in
            switch $0 {
            case .success:
                self?.output?.didCreated(result: .success(()))
            case .failure:
                self?.output?.didCreated(result: .failure(.unknown))
            }
        })
    }
}

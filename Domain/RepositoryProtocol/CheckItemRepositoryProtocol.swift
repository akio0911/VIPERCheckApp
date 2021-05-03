//
//  CheckItemRepositoryProtocol.swift
//  Domain
//
//  Created by akio0911 on 2021/05/03.
//

import Foundation

public enum CheckItemRepositoryError: Error {
    case decodingError
    case unknown
}

public protocol CheckItemRepositoryProtocol {
    func fetch(completion: @escaping (Result<[CheckItem], CheckItemRepositoryError>) -> Void)
    func create(name: String, completion: @escaping (Result<Void, CheckItemRepositoryError>) -> Void)
}

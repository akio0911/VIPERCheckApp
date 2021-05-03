//
//  CheckItemRepository.swift
//  Infra
//
//  Created by akio0911 on 2021/05/02.
//

// Repository は Domain モジュールにのみ依存する
import Domain

public struct CheckItemRepository: CheckItemRepositoryProtocol {
    public init() {}
    
    public func fetch(completion: @escaping (Result<[CheckItem], CheckItemRepositoryError>) -> Void) {
        guard let data = UserDefaults.standard.data(forKey: "check_items") else {
            completion(.failure(.decodingError))
            return
        }

        do {
            let checkItems = try JSONDecoder().decode([CheckItemDTO].self, from: data)
            completion(.success(checkItems.map(CheckItem.init)))
        } catch {
            completion(.failure(.decodingError))
        }
    }
}

private struct CheckItemDTO: Decodable {
    var name: String
    var isChecked: Bool
}

private extension CheckItem {
    init(dto: CheckItemDTO) {
        self.init(name: dto.name, isChecked: dto.isChecked)
    }
}

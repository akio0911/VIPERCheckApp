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

        switch CheckItemDataStore().fetch() {
        case .success(let checkItems):
            completion(.success(checkItems.map(CheckItem.init)))
        case .failure(let error):
            switch error {
            case .decodingError:
                completion(.failure(.decodingError))
            case .noData:
                completion(.failure(.unknown))
            }
        }
    }

    public func create(name: String, completion: @escaping (Result<Void, CheckItemRepositoryError>) -> Void) {

        if CheckItemDataStore().create(name: name) {
            completion(.success(()))
        } else {
            completion(.failure(.unknown))
        }
    }
}

private struct CheckItemDataStore {
    enum DataStoreError: Error {
        case noData
        case decodingError
    }

    private static let keyCheckItems = "check_items"

    func fetch() -> Result<[CheckItemDTO], DataStoreError> {
        guard let data = UserDefaults.standard.data(forKey: Self.keyCheckItems) else {
            return .failure(.noData)
        }

        do {
            let checkItems = try JSONDecoder().decode([CheckItemDTO].self, from: data)
            return .success(checkItems)
        } catch {
            return .failure(.decodingError)
        }
    }

    func create(name: String) -> Bool {
        func add(to checkItems: [CheckItemDTO]) -> Bool {
            let newCheckItem: CheckItemDTO
            if let max = checkItems.map(\.id).max() {
                newCheckItem = CheckItemDTO(id: max + 1, name: name, isChecked: false)
            } else {
                newCheckItem = CheckItemDTO(id: 1, name: name, isChecked: false)
            }

            do {
                let data = try JSONEncoder().encode(checkItems + [newCheckItem])
                UserDefaults.standard.set(data, forKey: Self.keyCheckItems)
                return true
            } catch {
                return false
            }
        }

        switch fetch() {
        case .success(let checkItems):
            return add(to: checkItems)
        case .failure(let error):
            switch error {
            case .decodingError:
                return false
            case .noData:
                return add(to: [])
            }
        }
    }
}

private struct CheckItemDTO: Codable {
    var id: Int
    var name: String
    var isChecked: Bool
}

private extension CheckItem {
    init(dto: CheckItemDTO) {
        self.init(
            id: CheckItemID(rawValue: dto.id),
            name: dto.name,
            isChecked: dto.isChecked
        )
    }
}

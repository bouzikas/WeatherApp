//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public struct CitiesViewModel {
    public static var shared = CitiesViewModel()
    
    public var viewModels = Observable<[CityViewModel]?>(nil)
    public var error = Observable<Error?>(nil)
    
    public func search(withTerm term: String, completion: @escaping (Error?, [CityViewModel]?) -> Void) {
        let query = [
            QueryKVO(
                key: Constants.QueryKeys.namePrefix,
                value: term
            )
        ]
        
        CitiesQueryDataRepository.shared.get(query: query) { (error) in
            completion(error, nil)
        }.0.bind { cities in
            guard let cities = cities else { return }
            
            let cityViewModels = cities.map {
                return CityViewModel(city: $0)
            }
            
            completion(nil, cityViewModels)
        }
    }
    
    public func fetchAll() -> Observable<[CityViewModel]?> {
        // clean previous results
        self.viewModels.value?.removeAll()
        
        do {
            let cityViewModels = try CacheDataManager.loadAll(
                CityViewModel.self
            )
                //.sorted(by: {$0.createdAt < $1.createdAt})
            self.viewModels.value = cityViewModels
        } catch {
            self.error.value = error
        }
        
        return self.viewModels
    }
}

struct SearchQuery: Codable {
    var term: String
    var createdAt: Date
    var itemIdentifier: UUID
    
    init(city: City) {
        self.term = city.name
        self.createdAt = Date()
        self.itemIdentifier = UUID(uuidString: city.name) ?? UUID()
    }
    
    func save() {
        CacheDataManager.save(self, with: "\(term)")
    }
    
    func delete() {
        CacheDataManager.delete(itemIdentifier.uuidString)
    }
    
    static func get(byTerm term: String) -> SearchQuery? {
        return CacheDataManager.load(term, with: SearchQuery.self)
    }
}

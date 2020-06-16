//
//  BaseQueryDataRepository.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public class BaseQueryDataRepository<Model>: PagingAndSortingRepository<Model, Pagination> {
    
    public func get(query: [QueryKVO], completion: @escaping (Error?) -> ()) -> (Observable<[Model]?>, Pagination?) {

        // cleanup previous resultSet
        self.resultSet.0.value = nil
        
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let results = try self.remoteDataSource.get(query: query)
                DispatchQueue.main.async {
                    self.resultSet.0.value = results.0
                    self.resultSet.1 = results.1
                }
            } catch {
                DispatchQueue.main.async {
                   completion(error)
                }
            }
        }
        
        return (self.resultSet.0, self.resultSet.1)
    }
    
    public func find(
        byId primaryKey: Int,
        andTerms terms: [QueryKVO],
        completion: @escaping (Error?) -> ()
    ) -> Observable<Model?> {
        
        // cleanup previous resultSet
        self.result.value = nil
        
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let results = try self.remoteDataSource.find(byId: primaryKey, query: terms)
                DispatchQueue.main.async {
                    self.result.value = results
                }
            } catch {
                DispatchQueue.main.async {
                   completion(error)
                }
            }
        }
        
        return self.result
    }
}

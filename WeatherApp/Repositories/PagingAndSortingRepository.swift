//
//  PagingAndSortingRepository.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public class PagingAndSortingRepository<T, ID> : BaseRepository<T, Pagination> {
    public func get(byTerms: [String: Any]) -> [T] { fatalError() }
    public func find(byId primaryKey: Int, andTerms terms: [String: Any]) -> T { fatalError() }
    
    public func findAll(/*Pageable pageable*/) -> Page<T> {
        fatalError("\(#function) missing implementation")
    }
}

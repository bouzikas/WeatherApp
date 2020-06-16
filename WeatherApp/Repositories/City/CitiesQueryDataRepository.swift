//
//  CitiesQueryDataRepository.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public class CitiesQueryDataRepository: BaseQueryDataRepository<City> {
    public static var shared = CitiesQueryDataRepository()
    
    public override init() {
        super.init()
        
        self.remoteDataSource = CitiesRemoteDataSource()
    }
    
    public override func get(
        query: [QueryKVO],
        completion: @escaping (Error?) -> ()
    ) -> (Observable<[City]?>, Pagination?) {
        return super.get(query: query, completion: completion)
    }
}

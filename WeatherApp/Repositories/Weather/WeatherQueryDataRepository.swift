//
//  WeatherQueryDataRepository.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 17/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import Foundation

public class WeatherQueryDataRepository: BaseQueryDataRepository<WeatherInfoDataResponse> {
    public static var shared = WeatherQueryDataRepository()
    
    public override init() {
        super.init()
        
        self.remoteDataSource = WeatherRemoteDataSource()
    }
    
    public override func find(
        byId primaryKey: Int,
        andTerms terms: [QueryKVO],
        completion: @escaping (Error?) -> ()
    ) -> Observable<WeatherInfoDataResponse?> {
        return super.find(byId: primaryKey, andTerms: terms, completion: completion)
    }
}

//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import XCTest
import Alamofire

@testable import WeatherApp

class CityAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExpectedSearchUrlAndParameters() {
        let query = [
            QueryKVO(
                key: Constants.QueryKeys.namePrefix,
                value: "New York"
            )
        ]
        let request = CitiesRequestBuilder.search(queries: query)
        
        guard let url = request.urlRequest?.url else {
            XCTFail(); return
        }
        let urlComponets = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        XCTAssertEqual(urlComponets?.host, "wft-geo-db.p.rapidapi.com")
        XCTAssertEqual(urlComponets?.path, "/v1/geo/cities")
        XCTAssertEqual(urlComponets?.query, "namePrefix=New York")
    }
    
    func testExpectedSearchValidResults() {
        var catchedResponse: ([City], Pagination)?
        let resultExpectation = expectation(description: "CitiesManager.search")
        
        DispatchQueue.global(qos: .userInteractive).async {
            let result = try! CitiesManager.shared.search(query: [
                QueryKVO(
                    key: Constants.QueryKeys.namePrefix,
                    value: "New York"
                )
            ])
            catchedResponse = result
            resultExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(catchedResponse)
        }
    }
}

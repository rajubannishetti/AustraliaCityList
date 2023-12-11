//
//  AustraliaCityListUnitTest.swift
//  AustraliaCityListUnitTest
//
//  Created by raju.bannishetti on 11/12/23.
//

import XCTest
@testable import AustraliaCityList

final class AustraliaCityListUnitTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    //Validating the Json file exist or not
    func test_JSON_Mapping_Success() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "au_cities", withExtension: "json") else {
            XCTFail("Missing file: au_cities.json")
            XCTAssert(false)
            return
        }
        
        let json = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        
        let result = try decoder.decode([City].self, from: json)
        
        if result.isEmpty {
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }

    }
    
    func test_JSON_File_Not_Found() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "au_city", withExtension: "json") else {
            return
        }
        
        let json = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        
        let result = try decoder.decode([City].self, from: json)
        
        let staticJSON = try StaticJSONMapper.decode(file: "au_city", type: [City].self)
        
        XCTAssertEqual(result, staticJSON, "The returned response should be decoded properly")
        XCTAssert(true)
    }
    
    func test_Network_Availability() throws {
        let network = NetworkMonitor()
        if network.isConnected {
            XCTFail("Network connection is not available")
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
    }
}

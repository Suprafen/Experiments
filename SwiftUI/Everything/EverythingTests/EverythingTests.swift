//
//  EverythingTests.swift
//  EverythingTests
//
//  Created by Ivan Pryhara on 6.01.23.
//

import XCTest

// Here you should provide app's name
@testable import Everything

final class EverythingTests: XCTestCase {

    let stuff = Stuff()
    
    func testAddition() {
        let result = stuff.add(x: 3, y: 4)
        
        XCTAssertEqual(result, 7)
    }
    
    func testSubtraction() {
        let result = stuff.subtract(x: 3, y: 4)
        
        XCTAssertEqual(result, -1)
    }
    
    func testMultiplication() {
        let result = stuff.multiply(x: 3, y: 4)
        
        XCTAssertEqual(result, 12)
    }
    
    func testDivision() {
        let result = stuff.divide(x: 3, y: 4)
        
        XCTAssertEqual(result, 11, "Isn't the result should be 11? Something wrong with the function or with parameters.")
    }
    
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

}

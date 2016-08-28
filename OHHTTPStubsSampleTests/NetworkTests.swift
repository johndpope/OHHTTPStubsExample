//
//  NetworkStubTests.swift
//  OHHTTPStubsSample
//
//  Created by Giovanni on 16/02/2016.
//  Copyright © 2016 mokagio. All rights reserved.
//

import XCTest
@testable import OHHTTPStubsSample

class NetworkStubTests: XCTestCase {

  func testGetResourceSuccess() {
    // Arrange
    //
    // Setup network stubs
    let testHost = "localhost:4567"
    let id = "42-abc"
    let stubbedJSON = [
      "id": id,
      "foo": "a value",
      "bar": "another value",
    ]

    // Setup System Under Test
    let client = APIClient(baseURL: NSURL(string: "http://\(testHost)")!)
    let expectation = self.expectationWithDescription("calls the callback with a resource object")

    // Act
    //
    client.getResource(withId: id) { resource, error in

      // Assert
      //
      XCTAssertNil(error)
      XCTAssertEqual(resource?.id, stubbedJSON["id"])
      XCTAssertEqual(resource?.aProperty, stubbedJSON["foo"])
      XCTAssertEqual(resource?.anotherPropert, stubbedJSON["bar"])

      expectation.fulfill()
    }

    self.waitForExpectationsWithTimeout(0.3, handler: .None)

    OHHTTPStubs.removeAllStubs()
  }

  func testGetResourceFailure() {
    // ???
  }
}

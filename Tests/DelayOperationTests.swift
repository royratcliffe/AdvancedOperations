// AdvancedOperationsTests DelayOperationTests.swift
//
// Copyright © 2016, Roy Ratcliffe, Pioneering Software, United Kingdom
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the “Software”), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS,” WITHOUT WARRANTY OF ANY KIND, EITHER
// EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//
//------------------------------------------------------------------------------

import XCTest
import AdvancedOperations

class DelayOperationTests: XCTestCase {

  /// Sets up a series of three interdependent operations: a first block
  /// operation that samples the current date and time, a one-second delay
  /// operation, then a last block operation that samples the current date-time
  /// as well as fulfilling a one-second delay expectation.
  func testOneSecond() {
    // given
    let expectation = self.expectation(withDescription: "OneSecond")
    let q = AdvancedOperations.OperationQueue()
    var firstDate: Date?
    let firstOp = BlockOperation {
      firstDate = Date()
    }
    let delayOp = DelayOperation(timeInterval: 1.0)
    var lastDate: Date?
    let lastOp = BlockOperation {
      lastDate = Date()
      expectation.fulfill()
    }

    // when
    firstOp.produce(dependent: delayOp)
    delayOp.produce(dependent: lastOp)
    q.add(operation: firstOp)

    // then
    waitForExpectations(withTimeout: 3.0) { (error) in
      if let error = error {
        NSLog("%@", error.localizedDescription)
      }
      XCTAssertNil(error)
    }
    XCTAssertNotNil(firstDate)
    XCTAssertNotNil(lastDate)
    XCTAssertEqualWithAccuracy(lastDate!.timeIntervalSince(firstDate!), 1.0, accuracy: 0.25)
  }

}

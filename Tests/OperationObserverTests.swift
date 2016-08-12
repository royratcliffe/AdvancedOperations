// AdvancedOperationsTests OperationObserverTests.swift
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

class OperationObserverTests: XCTestCase {

  /// Tests operation is-finished observations. Executes a three-second waiting
  /// operation while watching for its finished status to change from false to
  /// true.
  func testIsFinished() {
    // given
    let q = AdvancedOperations.OperationQueue()
    let op = BlockOperation {
      let semaphore = DispatchSemaphore(value: 0)
      DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + 3.0) {
        semaphore.signal()
      }
      let _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }
    let expectation = self.expectation(description: "IsFinished")
    op.add(observer: IsFinishedObserver { (_) in
      // Fulfills the expectation when the operation changes from not finished to
      // finished. Assumes that it only observes one operation, hence ignores
      // *which* operation finished, if there really are more than one.
      expectation.fulfill()
      })

    // when
    q.add(operation: op)

    // then
    waitForExpectations(timeout: 10.0, handler: nil)
  }

}

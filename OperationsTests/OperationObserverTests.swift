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
import Operations

class OperationObserverTests: XCTestCase {

  /// Fulfills an expectation when an operation changes from not finished to
  /// finished. Assumes that it only observes one operation, hence ignores
  /// *which* operation finished, if there really are more than one.
  class IsFinishedObserver: OperationChangeObserver {

    let expectation: XCTestExpectation

    init(_ expectation: XCTestExpectation) {
      self.expectation = expectation
    }

    override func operation(_: NSOperation, didChangeIsFinished isFinished: Bool, wasFinished: Bool) {
      if isFinished && wasFinished {
        expectation.fulfill()
      }
    }

  }

  /// Tests operation is-finished observations. Executes a three-second waiting
  /// operation while watching for its finished status to change from false to
  /// true.
  func testIsFinished() {
    // given
    let q = OperationQueue()
    let op = NSBlockOperation {
      let semaphore = dispatch_semaphore_create(0)
      let when = dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC)))
      dispatch_after(when, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)) {
        dispatch_semaphore_signal(semaphore)
      }
      dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }
    op.addObserver(IsFinishedObserver(expectationWithDescription("IsFinished")))

    // when
    q.addOperation(op)

    // then
    waitForExpectationsWithTimeout(100.0, handler: nil)
  }

}

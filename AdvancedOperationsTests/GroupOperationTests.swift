// AdvancedOperationsTests GroupOperationTests.swift
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

class GroupOperationTests: XCTestCase {

  let q = AdvancedOperations.OperationQueue()

  /// Adds a group operation to an operation queue. The group operation, in
  /// turn, adds a nested operation to its internal queue. The group operation
  /// then un-suspends the queue and waits for the sub-operation to finish.
  func testWaitUntilAllOperationsAreFinished() {
    // given
    class MyGroupOperation: GroupOperation {

      let expectation: XCTestExpectation

      init(_ expectation: XCTestExpectation) {
        self.expectation = expectation
      }

      private override func execute() {
        addOperation(BlockOperation())

        // This test would fail if the group operation failed to un-suspend its
        // queue. It would wait indefinitely for the queue to resume. Some other
        // operation or block would have to resume it.
        isSuspended = false

        waitUntilAllOperationsAreFinished()
        expectation.fulfill()
      }

    }
    let groupOp = MyGroupOperation(expectation(withDescription: "\(#function)"))

    // when
    q.addOperation(groupOp)

    // then
    waitForExpectations(withTimeout: 10.0, handler: nil)
  }

}

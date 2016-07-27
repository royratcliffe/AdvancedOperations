// AdvancedOperationsTests OperationLogTests.swift
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

class OperationLogTests: XCTestCase {

  /// Launch an empty block operation. Add a logging operation observer. The
  /// operation retains its observers. The Apple system log facility reports
  /// changes to the operation.
  func testLog() {
    // given
    let expectation = expectationWithDescription("Log")
    let q = OperationQueue()
    let op = Operation()
    let fulfillOp = NSBlockOperation {
      expectation.fulfill()
    }
    let observer = OperationLogObserver()
    q.name = "MyQueue"
    op.name = "MyOp"
    fulfillOp.name = "MyFulfillOp"

    // when
    op.addObserver(observer)
    fulfillOp.addObserver(observer)
    fulfillOp.produceDependency(op)
    op.queuePriority = .High
    fulfillOp.queuePriority = .Normal
    q.addOperation(fulfillOp)

    // then
    waitForExpectationsWithTimeout(10.0, handler: nil)
  }

}
// AdvancedOperationsTests OperationProducerTests.swift
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

class OperationProducerTests: XCTestCase {

  /// Produces an operation *before* the original producing operation belongs to
  /// a queue. Stashes the produced operation temporarily.
  func testStashOperation() {
    // given
    let q = AdvancedOperations.OperationQueue()
    let producingOp = BlockOperation {}
    let producedOp = BlockOperation {}
    let expectation = self.expectation(withDescription: "\(#function)")
    producedOp.add(observer: IsFinishedObserver { (op) in
      XCTAssert(op === producedOp)
      expectation.fulfill()
      })
    // when
    producingOp.produceOperation(producedOp)
    q.addOperation(producingOp)
    // then
    waitForExpectations(withTimeout: 10.0, handler: nil)
  }

  func testProduceOperation() {
    // given
    let q = AdvancedOperations.OperationQueue()
    let producingOp = BlockOperation {}
    let producedOp = BlockOperation {}
    let expectation = self.expectation(withDescription: "\(#function)")
    producedOp.add(observer: IsFinishedObserver { (op) in
      XCTAssert(op === producedOp)
      expectation.fulfill()
      })
    // when
    q.addOperation(producingOp)
    producingOp.produceOperation(producedOp)
    // then
    waitForExpectations(withTimeout: 10.0, handler: nil)
  }

  /// Produces an operation while executing.
  func testProduceOperationWhileExecuting() {
    // given
    let q = AdvancedOperations.OperationQueue()
    let producedOp = BlockOperation {}
    let producingOp = BlockOperation()
    producingOp.addExecutionBlock {
      producingOp.produceOperation(producedOp)
    }
    let expectation = self.expectation(withDescription: "\(#function)")
    producedOp.add(observer: IsFinishedObserver { (op) in
      XCTAssert(op === producedOp)
      expectation.fulfill()
      })
    // when
    q.addOperation(producingOp)
    // then
    waitForExpectations(withTimeout: 10.0, handler: nil)
  }

  func testProduceDependentWithBlock() {
    // given
    let q = AdvancedOperations.OperationQueue()
    let op = BlockOperation {}
    let expectation = self.expectation(withDescription: "\(#function)")
    // when
    let _ = op.produceDependentWithBlock { (op) in
      guard let op = op where !op.isCancelled else {
        return
      }
      expectation.fulfill()
    }
    q.addOperation(op)
    // then
    waitForExpectations(withTimeout: 10.0, handler: nil)
  }

}

// AdvancedOperations NSOperationQueue+Producer.swift
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

import Foundation

extension NSOperationQueue {

  /// Sets up producing of operations using this queue. This operation queue now
  /// acts as an operation-producer for the given operation. When the given
  /// operation produces another operation, this producer adds it to the
  /// queue. Additionally sets up any stashed operations. Replaces any existing
  /// operation producer.
  /// - parameter op: Operation to produce for.
  public func produceFor(operation op: NSOperation) {
    if let stash = op.producer as? OperationStash {
      addOperations(stash.operations, waitUntilFinished: false)
    }
    op.producer = ProduceHandler { [weak self] (op) in
      self?.addOperation(op)
    }
  }

}

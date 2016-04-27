// AdvancedOperations NSOperation+Producer.swift
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

var operationProducerKey = 0

extension NSOperation {

  /// Operations can have an associated producer. They have none by default. But
  /// if you produce an operation, a stash appears by default; see the
  /// `produceOperation()` implementation. Producing an operation thereby
  /// stashes the operation until later.
  public var producer: OperationProducer? {
    get {
      return objc_getAssociatedObject(self, &operationProducerKey) as? OperationProducer
    }
    set(newProducer) {
      objc_setAssociatedObject(self, &operationProducerKey, newProducer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

  /// Produces an operation. The given operation joins this operation's queue
  /// whenever you add this operation to an operation queue, or adds the
  /// operation immediately if a queue is already running this
  /// operation. Operations can produce other operations even while executing.
  ///
  /// The implementation either adds an operation to this operation's operation
  /// queue, or stashes the operation for adding to the same queue as this
  /// operation, whenever added. Sets up an `OperationStash` instance a
  /// temporary producer.
  ///
  /// Producing an operation only means adding an operation to this operations
  /// queue either immediately or whenever this operation gets added to an
  /// OperationQueue, but _not_ an NSOperationQueue. The latter do not know how
  /// to convert stashed operations to queued operations automatically. You have
  /// to trigger that step manually.
  ///
  /// - parameter op: Operation to produce.
  public func produceOperation(op: NSOperation) {
    willProduceOperation(op)
    if let producer = producer {
      producer.produceOperation(op)
    } else {
      producer = OperationStash(ops: op)
    }
    didProduceOperation(op)
  }

  public func willProduceOperation(op: NSOperation) {
    observer?.operation(self, willProduceOperation: op)
  }

  public func didProduceOperation(op: NSOperation) {
    observer?.operation(self, didProduceOperation: op)
  }

}

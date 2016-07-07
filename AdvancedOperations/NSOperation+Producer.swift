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
  public func produce(operation op: NSOperation) {
    willProduce(operation: op)
    if let producer = producer {
      producer.produce(operation: op)
    } else {
      producer = OperationStash(ops: op)
    }
    didProduce(operation: op)
  }

  /// Produces an operation dependency. This operation will depend on the given
  /// operation, which will launch in the same queue as this operation. The
  /// arrow of dependency goes from this operation to the given operation, and
  /// hence this operation will not start until `op` has finished; where
  /// finished includes cancelled.
  /// - parameter op: Operation to produce and make a dependency.
  public func produce(dependency op: NSOperation) {
    addDependency(op)
    produce(operation: op)
  }

  /// Produces a dependent operation.
  /// - parameter op: Operation to produce and make dependent on this
  ///   operation. Operation `op` will not start until this operation finishes.
  public func produce(dependent op: NSOperation) {
    op.addDependency(self)
    produce(operation: op)
  }

  /// Conveniently constructs a block operation using a given block, makes the
  /// new operation a dependency of this operation and produces it for enqueuing
  /// immediately or later; now or later depends on whether or not this
  /// operation has been queued already. When an operation produces another
  /// operation, it joins the same queue.
  /// - parameter block: Block to run with the new operation. The block cannot
  ///   access the operation since the method returns it. Therefore, the block
  ///   cannot test itself for cancellation. For this reason, the block takes
  ///   its block operation as an optional block operation argument; optional
  ///   because the execution block that invokes the given block retains the
  ///   block operation only weakly. This avoids retain cycles. The block should
  ///   guard that there is some operation and that the operation is not
  ///   cancelled before proceeding.
  ///
  ///       op.produceDependentWithBlock { (op) in
  ///         guard let op = op where !op.cancelled else {
  ///           return
  ///         }
  ///         // do something
  ///       }
  ///
  /// - returns: The newly produced block operation on which this operation
  ///   depends.
  public func produceDependencyWithBlock(block: (BlockOperation?) -> Void) -> BlockOperation {
    let op = BlockOperation()
    op.addExecutionBlock { [weak op] in
      block(op)
    }
    produce(dependency: op)
    return op
  }

  /// Produces a dependent block operation whose start delays until this
  /// operation finishes.
  public func produceDependentWithBlock(block: (BlockOperation?) -> Void) -> BlockOperation {
    let op = BlockOperation()
    op.addExecutionBlock { [weak op] in
      block(op)
    }
    produce(dependent: op)
    return op
  }

  public func willProduce(operation op: NSOperation) {
    observer?.operation(self, willProduceOperation: op)
  }

  public func didProduce(operation op: NSOperation) {
    observer?.operation(self, didProduceOperation: op)
  }

}

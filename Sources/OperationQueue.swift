// AdvancedOperations OperationQueue.swift
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

/// `OperationQueue` instances act just like `NSOperationQueue` instances except
/// that they override the `addOperation()` method in order to notify a delegate
/// about adding operations to the queue. They automatically register an
/// operation observer for every added operation. The observer relays operation
/// state change observations to the operation queue and thereby to its
/// delegate.
public class OperationQueue: NSOperationQueue {

  public weak var delegate: OperationQueueDelegate?

  /// Bounces operation notifications to the queue and indirectly to the queue
  /// delegate. This operation-change observer sub-class implements the observer
  /// protocol purely in order that delegates can also see what individual
  /// operations within the queue are doing, and when they do it. The operation
  /// thus strongly retains the observer but not the queue, since the queue is
  /// not a direct observer. The observer only weakly retains the queue, thus
  /// avoiding retain cycles.
  class OperationObserver: OperationChangeObserver {

    weak var q: OperationQueue?

    init(_ q: OperationQueue) {
      self.q = q
    }

    internal override func operation(_ op: NSOperation, willAddObserver observer: AdvancedOperations.OperationObserver) {
      q?.operation(op, willAddObserver: observer)
    }

    internal override func operation(_ op: NSOperation, didAddObserver observer: AdvancedOperations.OperationObserver) {
      q?.operation(op, didAddObserver: observer)
    }

    internal override func operation(_ op: NSOperation, willRemoveObserver observer: AdvancedOperations.OperationObserver) {
      q?.operation(op, willRemoveObserver: observer)
    }

    internal override func operation(_ op: NSOperation, didRemoveObserver observer: AdvancedOperations.OperationObserver) {
      q?.operation(op, didRemoveObserver: observer)
    }

    internal override func operationWillStart(_ op: NSOperation) {
      q?.operationWillStart(op)
    }

    internal override func operationDidStart(_ op: NSOperation) {
      q?.operationDidStart(op)
    }

    internal override func operationWillExecute(_ op: NSOperation) {
      q?.operationWillExecute(op)
    }

    internal override func operationDidExecute(_ op: NSOperation) {
      q?.operationDidExecute(op)
    }

    internal override func operationWillCancel(_ op: NSOperation) {
      q?.operationWillCancel(op)
    }

    internal override func operationDidCancel(_ op: NSOperation) {
      q?.operationDidCancel(op)
    }

    internal override func operation(_ op: NSOperation, willChangeIsCancelled isCancelled: Bool) {
      q?.operation(op, willChangeIsCancelled: isCancelled)
    }

    internal override func operation(_ op: NSOperation, didChangeIsCancelled isCancelled: Bool, wasCancelled: Bool) {
      q?.operation(op, didChangeIsCancelled: isCancelled, wasCancelled: wasCancelled)
    }

    internal override func operation(_ op: NSOperation, willChangeIsExecuting isExecuting: Bool) {
      q?.operation(op, willChangeIsExecuting: isExecuting)
    }

    internal override func operation(_ op: NSOperation, didChangeIsExecuting isExecuting: Bool, wasExecuting: Bool) {
      q?.operation(op, didChangeIsExecuting: isExecuting, wasExecuting: wasExecuting)
    }

    internal override func operation(_ op: NSOperation, willChangeIsFinished isFinished: Bool) {
      q?.operation(op, willChangeIsFinished: isFinished)
    }

    internal override func operation(_ op: NSOperation, didChangeIsFinished isFinished: Bool, wasFinished: Bool) {
      q?.operation(op, didChangeIsFinished: isFinished, wasFinished: wasFinished)
    }

    internal override func operation(_ op: NSOperation, willChangeIsReady isReady: Bool) {
      q?.operation(op, willChangeIsReady: isReady)
    }

    internal override func operation(_ op: NSOperation, didChangeIsReady isReady: Bool, wasReady: Bool) {
      q?.operation(op, didChangeIsReady: isReady, wasReady: wasReady)
    }

  }

  //----------------------------------------------------------------------------
  // MARK: - Delegate Notifications

  public func willAdd(operation op: NSOperation) {
    delegate?.operationQueue(self, willAddOperation: op)
  }

  /// Runs *after* running the underlying NSOperation.addOperation()
  /// method. Notifies the delegate, then adds itself (the queue) as an
  /// operation observer before finally making this queue the producer for the
  /// operation. Becoming the producer unloads the stash if there is one, adding
  /// all its operations to this queue also. As the new producer, this queue
  /// then automatically adds any further produced operations to the queue, as
  /// and when they appear.
  public func didAdd(operation op: NSOperation) {
    delegate?.operationQueue(self, didAddOperation: op)
    op.add(observer: OperationObserver(self))
    produceFor(operation: op)
  }

  public func operation(_ op: NSOperation, willAddObserver observer: AdvancedOperations.OperationObserver) {
    delegate?.operationQueue(self, operation: op, willAddObserver: observer)
  }

  public func operation(_ op: NSOperation, didAddObserver observer: AdvancedOperations.OperationObserver) {
    delegate?.operationQueue(self, operation: op, didAddObserver: observer)
  }

  public func operation(_ op: NSOperation, willRemoveObserver observer: AdvancedOperations.OperationObserver) {
    delegate?.operationQueue(self, operation: op, willRemoveObserver: observer)
  }

  public func operation(_ op: NSOperation, didRemoveObserver observer: AdvancedOperations.OperationObserver) {
    delegate?.operationQueue(self, operation: op, didRemoveObserver: observer)
  }

  public func operationWillStart(_ op: NSOperation) {
    delegate?.operationQueue(self, operationWillStart: op)
  }

  public func operationDidStart(_ op: NSOperation) {
    delegate?.operationQueue(self, operationDidStart: op)
  }

  public func operationWillExecute(_ op: NSOperation) {
    delegate?.operationQueue(self, operationWillExecute: op)
  }

  public func operationDidExecute(_ op: NSOperation) {
    delegate?.operationQueue(self, operationDidExecute: op)
  }

  public func operationWillCancel(_ op: NSOperation) {
    delegate?.operationQueue(self, operationWillCancel: op)
  }

  public func operationDidCancel(_ op: NSOperation) {
    delegate?.operationQueue(self, operationDidCancel: op)
  }

  public func operation(_ op: NSOperation, willChangeIsCancelled isCancelled: Bool) {
    delegate?.operationQueue(self, operation: op, willChangeIsCancelled: isCancelled)
  }

  public func operation(_ op: NSOperation, didChangeIsCancelled isCancelled: Bool, wasCancelled: Bool) {
    delegate?.operationQueue(self, operation: op, didChangeIsCancelled: isCancelled, wasCancelled: wasCancelled)
  }

  public func operation(_ op: NSOperation, willChangeIsExecuting isExecuting: Bool) {
    delegate?.operationQueue(self, operation: op, willChangeIsExecuting: isExecuting)
  }

  public func operation(_ op: NSOperation, didChangeIsExecuting isExecuting: Bool, wasExecuting: Bool) {
    delegate?.operationQueue(self, operation: op, didChangeIsExecuting: isExecuting, wasExecuting: wasExecuting)
  }

  public func operation(_ op: NSOperation, willChangeIsFinished isFinished: Bool) {
    delegate?.operationQueue(self, operation: op, willChangeIsFinished: isFinished)
  }

  public func operation(_ op: NSOperation, didChangeIsFinished isFinished: Bool, wasFinished: Bool) {
    delegate?.operationQueue(self, operation: op, didChangeIsFinished: isFinished, wasFinished: wasFinished)
  }

  public func operation(_ op: NSOperation, willChangeIsReady isReady: Bool) {
    delegate?.operationQueue(self, operation: op, willChangeIsReady: isReady)
  }

  public func operation(_ op: NSOperation, didChangeIsReady isReady: Bool, wasReady: Bool) {
    delegate?.operationQueue(self, operation: op, didChangeIsReady: isReady, wasReady: wasReady)
  }

  public func add(operation: NSOperation) {
    addOperation(operation)
  }

  public func add(operations: [NSOperation], waitUntilFinished: Bool) {
    addOperations(operations, waitUntilFinished: waitUntilFinished)
  }

  //----------------------------------------------------------------------------
  // MARK: - NSOperationQueue Overrides

  public override func addOperation(_ op: NSOperation) {
    willAdd(operation: op)
    super.addOperation(op)
    didAdd(operation: op)
  }

  // Adds operations and optionally waits until finishes. This implementation
  // entirely replaces that of the underlying `NSOperation` method since the
  // super-class does not invoke `addOperation()` iteratively when adding.
  public override func addOperations(_ ops: [NSOperation], waitUntilFinished wait: Bool) {
    for op in ops {
      add(operation: op)
    }
    if wait {
      waitUntilAllOperationsAreFinished()
    }
  }

}

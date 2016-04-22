// Operations OperationQueue.swift
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

    internal func operationWillAddObserver(op: NSOperation) {
      q?.operationWillAddObserver(op)
    }

    internal func operationDidAddObserver(op: NSOperation) {
      q?.operationDidAddObserver(op)
    }

    internal func operationWillRemoveObserver(op: NSOperation) {
      q?.operationWillRemoveObserver(op)
    }

    internal func operationDidRemoveObserver(op: NSOperation) {
      q?.operationDidRemoveObserver(op)
    }

    internal func operationWillStart(op: NSOperation) {
      q?.operationWillStart(op)
    }

    internal func operationDidStart(op: NSOperation) {
      q?.operationDidStart(op)
    }

    internal func operationWillExecute(op: NSOperation) {
      q?.operationWillExecute(op)
    }

    internal func operationDidExecute(op: NSOperation) {
      q?.operationDidExecute(op)
    }

    internal func operationWillCancel(op: NSOperation) {
      q?.operationWillCancel(op)
    }

    internal func operationDidCancel(op: NSOperation) {
      q?.operationDidCancel(op)
    }

    internal func operation(op: NSOperation, willChangeIsCancelled isCancelled: Bool) {
      q?.operation(op, willChangeIsCancelled: isCancelled)
    }

    internal func operation(op: NSOperation, didChangeIsCancelled isCancelled: Bool, wasCancelled: Bool) {
      q?.operation(op, didChangeIsCancelled: isCancelled, wasCancelled: wasCancelled)
    }

    internal func operation(op: NSOperation, willChangeIsExecuting isExecuting: Bool) {
      q?.operation(op, willChangeIsExecuting: isExecuting)
    }

    internal func operation(op: NSOperation, didChangeIsExecuting isExecuting: Bool, wasExecuting: Bool) {
      q?.operation(op, didChangeIsExecuting: isExecuting, wasExecuting: wasExecuting)
    }

    internal func operation(op: NSOperation, willChangeIsFinished isFinished: Bool) {
      q?.operation(op, willChangeIsFinished: isFinished)
    }

    internal func operation(op: NSOperation, didChangeIsFinished isFinished: Bool, wasFinished: Bool) {
      q?.operation(op, didChangeIsFinished: isFinished, wasFinished: wasFinished)
    }

    internal func operation(op: NSOperation, willChangeIsReady isReady: Bool) {
      q?.operation(op, willChangeIsReady: isReady)
    }

    internal func operation(op: NSOperation, didChangeIsReady isReady: Bool, wasReady: Bool) {
      q?.operation(op, didChangeIsReady: isReady, wasReady: wasReady)
    }

  }

  //----------------------------------------------------------------------------
  // MARK: - Delegate Notifications

  func willAddOperation(op: NSOperation) {
    delegate?.operationQueue(self, willAddOperation: op)
  }

  func didAddOperation(op: NSOperation) {
    delegate?.operationQueue(self, didAddOperation: op)
    op.addObserver(OperationObserver(self))
  }

  public func operationWillAddObserver(op: NSOperation) {
    delegate?.operationQueue(self, operationWillAddObserver: op)
  }

  public func operationDidAddObserver(op: NSOperation) {
    delegate?.operationQueue(self, operationDidAddObserver: op)
  }

  public func operationWillRemoveObserver(op: NSOperation) {
    delegate?.operationQueue(self, operationWillRemoveObserver: op)
  }

  public func operationDidRemoveObserver(op: NSOperation) {
    delegate?.operationQueue(self, operationDidRemoveObserver: op)
  }

  public func operationWillStart(op: NSOperation) {
    delegate?.operationQueue(self, operationWillStart: op)
  }

  public func operationDidStart(op: NSOperation) {
    delegate?.operationQueue(self, operationDidStart: op)
  }

  public func operationWillExecute(op: NSOperation) {
    delegate?.operationQueue(self, operationWillExecute: op)
  }

  public func operationDidExecute(op: NSOperation) {
    delegate?.operationQueue(self, operationDidExecute: op)
  }

  public func operationWillCancel(op: NSOperation) {
    delegate?.operationQueue(self, operationWillCancel: op)
  }

  public func operationDidCancel(op: NSOperation) {
    delegate?.operationQueue(self, operationDidCancel: op)
  }

  public func operation(op: NSOperation, willChangeIsCancelled isCancelled: Bool) {
    delegate?.operationQueue(self, operation: op, willChangeIsCancelled: isCancelled)
  }

  public func operation(op: NSOperation, didChangeIsCancelled isCancelled: Bool, wasCancelled: Bool) {
    delegate?.operationQueue(self, operation: op, didChangeIsCancelled: isCancelled, wasCancelled: wasCancelled)
  }

  public func operation(op: NSOperation, willChangeIsExecuting isExecuting: Bool) {
    delegate?.operationQueue(self, operation: op, willChangeIsExecuting: isExecuting)
  }

  public func operation(op: NSOperation, didChangeIsExecuting isExecuting: Bool, wasExecuting: Bool) {
    delegate?.operationQueue(self, operation: op, didChangeIsExecuting: isExecuting, wasExecuting: wasExecuting)
  }

  public func operation(op: NSOperation, willChangeIsFinished isFinished: Bool) {
    delegate?.operationQueue(self, operation: op, willChangeIsFinished: isFinished)
  }

  public func operation(op: NSOperation, didChangeIsFinished isFinished: Bool, wasFinished: Bool) {
    delegate?.operationQueue(self, operation: op, didChangeIsFinished: isFinished, wasFinished: wasFinished)
  }

  public func operation(op: NSOperation, willChangeIsReady isReady: Bool) {
    delegate?.operationQueue(self, operation: op, willChangeIsReady: isReady)
  }

  public func operation(op: NSOperation, didChangeIsReady isReady: Bool, wasReady: Bool) {
    delegate?.operationQueue(self, operation: op, didChangeIsReady: isReady, wasReady: wasReady)
  }

  //----------------------------------------------------------------------------
  // MARK: - NSOperationQueue Overrides

  public override func addOperation(op: NSOperation) {
    willAddOperation(op)
    super.addOperation(op)
    didAddOperation(op)
  }

}

// AdvancedOperations OperationQueueDelegates.swift
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

/// Implements an operation-queue delegate that relays delegate notifications to
/// zero or more *other* operation-queue delegates. The `addDelegate()` method
/// of `OperationQueue` uses an instance of this class to add new delegates when
/// an already-existing delegate appears for the queue.
public class OperationQueueDelegates: OperationQueueDelegate {

  var delegates = [OperationQueueDelegate]()

  public func add(delegate: OperationQueueDelegate) {
    delegates.append(delegate)
  }

  //----------------------------------------------------------------------------
  // MARK: - OperationQueueDelegate

  public func operationQueue(_ q: OperationQueue, willAddOperation op: NSOperation) {
    for delegate in delegates {
      delegate.operationQueue(q, willAddOperation: op)
    }
  }

  public func operationQueue(_ q: OperationQueue, didAddOperation op: NSOperation) {
    for delegate in delegates {
      delegate.operationQueue(q, didAddOperation: op)
    }
  }

  public func operationQueue(_ q: OperationQueue, operation op: NSOperation, willAddObserver observer: OperationObserver) {
    for delegate in delegates {
      delegate.operationQueue(q, operation: op, willAddObserver: observer)
    }
  }

  public func operationQueue(_ q: OperationQueue, operation op: NSOperation, didAddObserver observer: OperationObserver) {
    for delegate in delegates {
      delegate.operationQueue(q, operation: op, didAddObserver: observer)
    }
  }

  public func operationQueue(_ q: OperationQueue, operation op: NSOperation, willRemoveObserver observer: OperationObserver) {
    for delegate in delegates {
      delegate.operationQueue(q, operation: op, willRemoveObserver: observer)
    }
  }

  public func operationQueue(_ q: OperationQueue, operation op: NSOperation, didRemoveObserver observer: OperationObserver) {
    for delegate in delegates {
      delegate.operationQueue(q, operation: op, didRemoveObserver: observer)
    }
  }

  public func operationQueue(_ q: OperationQueue, operationWillStart op: NSOperation) {
    for delegate in delegates {
      delegate.operationQueue(q, operationWillStart: op)
    }
  }

  public func operationQueue(_ q: OperationQueue, operationDidStart op: NSOperation) {
    for delegate in delegates {
      delegate.operationQueue(q, operationDidStart: op)
    }
  }

  public func operationQueue(_ q: OperationQueue, operationWillExecute op: NSOperation) {
    for delegate in delegates {
      delegate.operationQueue(q, operationWillExecute: op)
    }
  }

  public func operationQueue(_ q: OperationQueue, operationDidExecute op: NSOperation) {
    for delegate in delegates {
      delegate.operationQueue(q, operationDidExecute: op)
    }
  }

  public func operationQueue(_ q: OperationQueue, operationWillCancel op: NSOperation) {
    for delegate in delegates {
      delegate.operationQueue(q, operationWillCancel: op)
    }
  }

  public func operationQueue(_ q: OperationQueue, operationDidCancel op: NSOperation) {
    for delegate in delegates {
      delegate.operationQueue(q, operationDidCancel: op)
    }
  }

}

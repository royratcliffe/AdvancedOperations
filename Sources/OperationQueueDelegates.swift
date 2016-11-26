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
/// zero or more *other* operation-queue delegates. The `add(delegate:)` method
/// of `OperationQueue` uses an instance of this class to add new delegates when
/// an already-existing delegate appears for the queue.
public class OperationQueueDelegates: OperationQueueDelegate {

  var delegates = [OperationQueueDelegate]()

  /// Adds an operation-queue delegate to this collection of delegates. Does not
  /// check for the delegate already existing in this collection; adds the
  /// delegate regardless. In such a case, a delegate will receive the same
  /// delegate message more than once.
  /// - parameter delegate: Object implementing the operation-queue delegate
  ///   protocol.
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

}

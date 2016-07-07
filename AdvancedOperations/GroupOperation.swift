// AdvancedOperations GroupOperation.swift
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

/// Operation that runs its own internal operation queue so that you can add one
/// or more sub-operations and wait for them to finish during execution of this
/// operation. You can add sub-operations at any time, and wait for operations
/// more than once.
public class GroupOperation: Operation {

  /// Accesses the underlying group operation queue. Sub-classes or other
  /// callers can access the queue directly, if necessary. It might be necessary
  /// for example, when needing to key-value observe the group's underlying
  /// operation queue. Most of the underlying group queue's properties comply
  /// with key-value observing protocols.
  public let underlyingQueue = OperationQueue()

  public override init() {
    super.init()
    underlyingQueue.delegate = self
  }

  /// Adds a given operation to this operation group. The given operation does
  /// not start until *this* operation starts. The group itself is an operation
  /// that needs adding to an operation queue in order to kickstart the group.
  /// - parameter op: Operation to add to this group.
  public func add(operation op: NSOperation) {
    underlyingQueue.add(operation: op)
  }

  /// Accesses the group's suspend status. The group starts off suspended. Make
  /// `suspended` equal to false in order to start any added group operations.
  public var isSuspended: Bool {
    get {
      return underlyingQueue.isSuspended
    }
    set(newIsSuspended) {
      underlyingQueue.isSuspended = newIsSuspended
    }
  }

  /// Accesses the group operation queue's quality of service. It defaults to
  /// background quality.
  public var underlyingQualityOfService: QualityOfService {
    get {
      return underlyingQueue.qualityOfService
    }
    set(newUnderlyingQualityOfService) {
      underlyingQueue.qualityOfService = newUnderlyingQualityOfService
    }
  }

  /// Cancels all group sub-operations.
  public func cancelAllOperations() {
    underlyingQueue.cancelAllOperations()
  }

  /// Waits until all the group's operations are finished.
  ///
  /// Does *not* automatically resume the group's operation queue. Waiting for
  /// the group operations makes no sense when the queue is suspended. The
  /// operation will wait forever unless empty. Empty queues will not wait
  /// because all its operations have finished, because there are none
  /// remaining.
  public func waitUntilAllOperationsAreFinished() {
    underlyingQueue.waitUntilAllOperationsAreFinished()
  }

  /// Waits for all group sub-operations to finish, then checks if the operation
  /// itself has been cancelled. That does not mean that the finished
  /// sub-operations themselves were cancelled.
  /// - returns: True if this operation has been cancelled and should terminate
  ///   at the earliest opportunity, false if the operation should continue.
  public func waitUntilNotCancelled() -> Bool {
    waitUntilAllOperationsAreFinished()
    return !isCancelled
  }

  //----------------------------------------------------------------------------
  // MARK: - Operation Overrides

  /// Runs unless cancelled. Un-suspends the group operation queue; the queue
  /// was suspended initially. Then waits for all operations in the queue to
  /// finish. Finishing includes cancelling. Hence when this operation finishes,
  /// all its component operations have also finished.
  public override func execute() {
    isSuspended = false
    waitUntilAllOperationsAreFinished()
  }

}

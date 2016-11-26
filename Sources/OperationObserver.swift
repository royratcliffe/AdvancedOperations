// AdvancedOperations OperationObserver.swift
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

/// An operation observer can observe more than one operation, if required. All
/// operation observer methods include the operation for which the observation
/// was made. It appears as the first parameter.
public protocol OperationObserver: class {

  func operation(_ op: NSOperation, willAddObserver observer: OperationObserver)

  func operation(_ op: NSOperation, didAddObserver observer: OperationObserver)

  func operation(_ op: NSOperation, willRemoveObserver observer: OperationObserver)

  func operation(_ op: NSOperation, didRemoveObserver observer: OperationObserver)

  func operationWillStart(_ op: NSOperation)

  func operationDidStart(_ op: NSOperation)

  func operationWillExecute(_ op: NSOperation)

  func operationDidExecute(_ op: NSOperation)

  func operationWillCancel(_ op: NSOperation)

  func operationDidCancel(_ op: NSOperation)

  func operation(_ op: NSOperation, willChangeIsCancelled isCancelled: Bool)

  func operation(_ op: NSOperation, didChangeIsCancelled isCancelled: Bool, wasCancelled: Bool)

  func operation(_ op: NSOperation, willChangeIsExecuting isExecuting: Bool)

  func operation(_ op: NSOperation, didChangeIsExecuting isExecuting: Bool, wasExecuting: Bool)

  func operation(_ op: NSOperation, willChangeIsFinished isFinished: Bool)

  func operation(_ op: NSOperation, didChangeIsFinished isFinished: Bool, wasFinished: Bool)

  func operation(_ op: NSOperation, willChangeIsReady isReady: Bool)

  func operation(_ op: NSOperation, didChangeIsReady isReady: Bool, wasReady: Bool)

  func operation(_ op: NSOperation, willChangeDependencies dependencies: [NSOperation])

  func operation(_ op: NSOperation, didChangeDependencies dependencies: [NSOperation], hadDependencies: [NSOperation])

  func operation(_ op: NSOperation, willChangeQueuePriority queuePriority: Operation.QueuePriority)

  func operation(_ op: NSOperation, didChangeQueuePriority queuePriority: Operation.QueuePriority, hadQueuePriority: Operation.QueuePriority)

  func operation(_ op: NSOperation, willProduceOperation newOp: NSOperation)

  func operation(_ op: NSOperation, didProduceOperation newOp: NSOperation)

}

extension OperationObserver {

  public func operation(_ op: NSOperation, willAddObserver observer: OperationObserver) {}

  public func operation(_ op: NSOperation, didAddObserver observer: OperationObserver) {}

  public func operation(_ op: NSOperation, willRemoveObserver observer: OperationObserver) {}

  public func operation(_ op: NSOperation, didRemoveObserver observer: OperationObserver) {}

  public func operationWillStart(_ op: NSOperation) {}

  public func operationDidStart(_ op: NSOperation) {}

  public func operationWillExecute(_ op: NSOperation) {}

  public func operationDidExecute(_ op: NSOperation) {}

  public func operationWillCancel(_ op: NSOperation) {}

  public func operationDidCancel(_ op: NSOperation) {}

  public func operation(_ op: NSOperation, willChangeIsCancelled isCancelled: Bool) {}

  public func operation(_ op: NSOperation, didChangeIsCancelled isCancelled: Bool, wasCancelled: Bool) {}

  public func operation(_ op: NSOperation, willChangeIsExecuting isExecuting: Bool) {}

  public func operation(_ op: NSOperation, didChangeIsExecuting isExecuting: Bool, wasExecuting: Bool) {}

  public func operation(_ op: NSOperation, willChangeIsFinished isFinished: Bool) {}

  public func operation(_ op: NSOperation, didChangeIsFinished isFinished: Bool, wasFinished: Bool) {}

  public func operation(_ op: NSOperation, willChangeIsReady isReady: Bool) {}

  public func operation(_ op: NSOperation, didChangeIsReady isReady: Bool, wasReady: Bool) {}

  public func operation(_ op: NSOperation, willChangeDependencies dependencies: [NSOperation]) {}

  public func operation(_ op: NSOperation, didChangeDependencies dependencies: [NSOperation], hadDependencies: [NSOperation]) {}

  public func operation(_ op: NSOperation, willChangeQueuePriority queuePriority: Operation.QueuePriority) {}

  public func operation(_ op: NSOperation, didChangeQueuePriority queuePriority: Operation.QueuePriority, hadQueuePriority: Operation.QueuePriority) {}

  public func operation(_ op: NSOperation, willProduceOperation newOp: NSOperation) {}

  public func operation(_ op: NSOperation, didProduceOperation newOp: NSOperation) {}

}

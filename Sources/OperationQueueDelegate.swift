// AdvancedOperations OperationQueueDelegate.swift
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

public protocol OperationQueueDelegate: class {

  func operationQueue(_ q: OperationQueue, willAddOperation op: NSOperation)

  func operationQueue(_ q: OperationQueue, didAddOperation op: NSOperation)

  func operationQueue(_ q: OperationQueue, operation op: NSOperation, willAddObserver observer: OperationObserver)

  func operationQueue(_ q: OperationQueue, operation op: NSOperation, didAddObserver observer: OperationObserver)

  func operationQueue(_ q: OperationQueue, operation op: NSOperation, willRemoveObserver observer: OperationObserver)

  func operationQueue(_ q: OperationQueue, operation op: NSOperation, didRemoveObserver observer: OperationObserver)

  func operationQueue(_ q: OperationQueue, operationWillStart op: NSOperation)

  func operationQueue(_ q: OperationQueue, operationDidStart op: NSOperation)

  func operationQueue(_ q: OperationQueue, operationWillExecute op: NSOperation)

  func operationQueue(_ q: OperationQueue, operationDidExecute op: NSOperation)

  func operationQueue(_ q: OperationQueue, operationWillCancel op: NSOperation)

  func operationQueue(_ q: OperationQueue, operationDidCancel op: NSOperation)

  func operationQueue(_ q: OperationQueue, operation op: NSOperation, willChangeIsCancelled isCancelled: Bool)

  func operationQueue(_ q: OperationQueue, operation op: NSOperation, didChangeIsCancelled isCancelled: Bool, wasCancelled: Bool)

  func operationQueue(_ q: OperationQueue, operation op: NSOperation, willChangeIsExecuting isExecuting: Bool)

  func operationQueue(_ q: OperationQueue, operation op: NSOperation, didChangeIsExecuting isExecuting: Bool, wasExecuting: Bool)

  func operationQueue(_ q: OperationQueue, operation op: NSOperation, willChangeIsFinished isFinished: Bool)

  func operationQueue(_ q: OperationQueue, operation op: NSOperation, didChangeIsFinished isFinished: Bool, wasFinished: Bool)

  func operationQueue(_ q: OperationQueue, operation op: NSOperation, willChangeIsReady isReady: Bool)

  func operationQueue(_ q: OperationQueue, operation op: NSOperation, didChangeIsReady isReady: Bool, wasReady: Bool)

}

extension OperationQueueDelegate {

  public func operationQueue(_ q: OperationQueue, willAddOperation op: NSOperation) {}

  public func operationQueue(_ q: OperationQueue, didAddOperation op: NSOperation) {}

  public func operationQueue(_ q: OperationQueue, operation op: NSOperation, willAddObserver observer: OperationObserver) {}

  public func operationQueue(_ q: OperationQueue, operation op: NSOperation, didAddObserver observer: OperationObserver) {}

  public func operationQueue(_ q: OperationQueue, operation op: NSOperation, willRemoveObserver observer: OperationObserver) {}

  public func operationQueue(_ q: OperationQueue, operation op: NSOperation, didRemoveObserver observer: OperationObserver) {}

  public func operationQueue(_ q: OperationQueue, operationWillStart op: NSOperation) {}

  public func operationQueue(_ q: OperationQueue, operationDidStart op: NSOperation) {}

  public func operationQueue(_ q: OperationQueue, operationWillExecute op: NSOperation) {}

  public func operationQueue(_ q: OperationQueue, operationDidExecute op: NSOperation) {}

  public func operationQueue(_ q: OperationQueue, operationWillCancel op: NSOperation) {}

  public func operationQueue(_ q: OperationQueue, operationDidCancel op: NSOperation) {}

  public func operationQueue(_ q: OperationQueue, operation op: NSOperation, willChangeIsCancelled isCancelled: Bool) {}

  public func operationQueue(_ q: OperationQueue, operation op: NSOperation, didChangeIsCancelled isCancelled: Bool, wasCancelled: Bool) {}

  public func operationQueue(_ q: OperationQueue, operation op: NSOperation, willChangeIsExecuting isExecuting: Bool) {}

  public func operationQueue(_ q: OperationQueue, operation op: NSOperation, didChangeIsExecuting isExecuting: Bool, wasExecuting: Bool) {}

  public func operationQueue(_ q: OperationQueue, operation op: NSOperation, willChangeIsFinished isFinished: Bool) {}

  public func operationQueue(_ q: OperationQueue, operation op: NSOperation, didChangeIsFinished isFinished: Bool, wasFinished: Bool) {}

  public func operationQueue(_ q: OperationQueue, operation op: NSOperation, willChangeIsReady isReady: Bool) {}

  public func operationQueue(_ q: OperationQueue, operation op: NSOperation, didChangeIsReady isReady: Bool, wasReady: Bool) {}

}

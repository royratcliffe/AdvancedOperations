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

  func operationWillAddObserver(op: NSOperation)

  func operationDidAddObserver(op: NSOperation)

  func operationWillRemoveObserver(op: NSOperation)

  func operationDidRemoveObserver(op: NSOperation)

  func operationWillStart(op: NSOperation)

  func operationDidStart(op: NSOperation)

  func operationWillExecute(op: NSOperation)

  func operationDidExecute(op: NSOperation)

  func operationWillCancel(op: NSOperation)

  func operationDidCancel(op: NSOperation)

  func operation(op: NSOperation, willChangeIsCancelled isCancelled: Bool)

  func operation(op: NSOperation, didChangeIsCancelled isCancelled: Bool, wasCancelled: Bool)

  func operation(op: NSOperation, willChangeIsExecuting isExecuting: Bool)

  func operation(op: NSOperation, didChangeIsExecuting isExecuting: Bool, wasExecuting: Bool)

  func operation(op: NSOperation, willChangeIsFinished isFinished: Bool)

  func operation(op: NSOperation, didChangeIsFinished isFinished: Bool, wasFinished: Bool)

  func operation(op: NSOperation, willChangeIsReady isReady: Bool)

  func operation(op: NSOperation, didChangeIsReady isReady: Bool, wasReady: Bool)

}

extension OperationObserver {

  public func operationWillAddObserver(op: NSOperation) {}

  public func operationDidAddObserver(op: NSOperation) {}

  public func operationWillRemoveObserver(op: NSOperation) {}

  public func operationDidRemoveObserver(op: NSOperation) {}

  public func operationWillStart(op: NSOperation) {}

  public func operationDidStart(op: NSOperation) {}

  public func operationWillExecute(op: NSOperation) {}

  public func operationDidExecute(op: NSOperation) {}

  public func operationWillCancel(op: NSOperation) {}

  public func operationDidCancel(op: NSOperation) {}

  public func operation(op: NSOperation, willChangeIsCancelled isCancelled: Bool) {}

  public func operation(op: NSOperation, didChangeIsCancelled isCancelled: Bool, wasCancelled: Bool) {}

  public func operation(op: NSOperation, willChangeIsExecuting isExecuting: Bool) {}

  public func operation(op: NSOperation, didChangeIsExecuting isExecuting: Bool, wasExecuting: Bool) {}

  public func operation(op: NSOperation, willChangeIsFinished isFinished: Bool) {}

  public func operation(op: NSOperation, didChangeIsFinished isFinished: Bool, wasFinished: Bool) {}

  public func operation(op: NSOperation, willChangeIsReady isReady: Bool) {}

  public func operation(op: NSOperation, didChangeIsReady isReady: Bool, wasReady: Bool) {}

}

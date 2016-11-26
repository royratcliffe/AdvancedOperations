// AdvancedOperations OperationChangeObserver.swift
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

public class OperationChangeObserver: KeyValueObserver, OperationObserver {

  /// Observes a given operation. Observes all its key-value-observing compliant
  /// properties.
  public func add(operation op: NSOperation) {
    for keyPath in ["isCancelled",
                    "isExecuting",
                    "isFinished",
                    "isAsynchronous",
                    "isReady",
                    "dependencies",
                    "queuePriority",
                    "completionBlock"] {
      add(object: op, keyPath: keyPath, options: [.new, .old, .prior])
    }
  }

  /// Removes all observations for the given operation.
  public func remove(operation op: NSOperation) {
    remove(object: op)
  }

  func op(_ op: NSOperation, willChangeIsCancelled isCancelled: Bool) {
    operation(op, willChangeIsCancelled: isCancelled)
  }

  func op(_ op: NSOperation, willChangeIsExecuting isExecuting: Bool) {
    operation(op, willChangeIsExecuting: isExecuting)
  }

  func op(_ op: NSOperation, willChangeIsFinished isFinished: Bool) {
    operation(op, willChangeIsFinished: isFinished)
  }

  func op(_ op: NSOperation, willChangeIsReady isReady: Bool) {
    operation(op, willChangeIsReady: isReady)
  }

  static let willChangeIs = [
    "isCancelled": OperationChangeObserver.op(_:willChangeIsCancelled:),
    "isExecuting": OperationChangeObserver.op(_:willChangeIsExecuting:),
    "isFinished": OperationChangeObserver.op(_:willChangeIsFinished:),
    "isReady": OperationChangeObserver.op(_:willChangeIsReady:),
  ]

  public func operation(_ op: NSOperation, willChange keyPath: String, oldValue: Any) {
    switch oldValue {
    case let oldBool as Bool:
      OperationChangeObserver.willChangeIs[keyPath]?(self)(op, oldBool)
    default:
      switch keyPath {
      case "dependencies":
        guard let oldValue = oldValue as? [NSOperation] else {
          return
        }
        operation(op, willChangeDependencies: oldValue)
      case "queuePriority":
        guard let oldValue = oldValue as? Operation.QueuePriority else {
          return
        }
        operation(op, willChangeQueuePriority: oldValue)
      default:
        break
      }
    }
  }

  func op(_ op: NSOperation, didChangeIsCancelled isCancelled: Bool, wasCancelled: Bool) {
    operation(op, didChangeIsCancelled: isCancelled, wasCancelled: wasCancelled)
  }

  func op(_ op: NSOperation, didChangeIsExecuting isExecuting: Bool, wasExecuting: Bool) {
    operation(op, didChangeIsExecuting: isExecuting, wasExecuting: wasExecuting)
  }

  func op(_ op: NSOperation, didChangeIsFinished isFinished: Bool, wasFinished: Bool) {
    operation(op, didChangeIsFinished: isFinished, wasFinished: wasFinished)
  }

  func op(_ op: NSOperation, didChangeIsReady isReady: Bool, wasReady: Bool) {
    operation(op, didChangeIsReady: isReady, wasReady: wasReady)
  }

  static let didChangeIs = [
    "isCancelled": OperationChangeObserver.op(_:didChangeIsCancelled:wasCancelled:),
    "isExecuting": OperationChangeObserver.op(_:didChangeIsExecuting:wasExecuting:),
    "isFinished": OperationChangeObserver.op(_:didChangeIsFinished:wasFinished:),
    "isReady": OperationChangeObserver.op(_:didChangeIsReady:wasReady:),
  ]

  public func operation(_ op: NSOperation, didChange keyPath: String, oldValue: Any, newValue: Any) {
    switch oldValue {
    case let oldBool as Bool:
      switch newValue {
      case let newBool as Bool:
        OperationChangeObserver.didChangeIs[keyPath]?(self)(op, newBool, oldBool)
      default:
        break
      }
    default:
      switch keyPath {
      case "dependencies":
        guard let oldValue = oldValue as? [NSOperation],
          let newValue = newValue as? [NSOperation] else {
            return
        }
        operation(op, didChangeDependencies: newValue, hadDependencies: oldValue)
      case "queuePriority":
        guard let oldValue = oldValue as? Operation.QueuePriority,
          let newValue = newValue as? Operation.QueuePriority else {
            return
        }
        operation(op, didChangeQueuePriority: newValue, hadQueuePriority: oldValue)
      default:
        break
      }
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - KeyValueObserver

  override func observeValue(forKeyPath keyPath: String,
                             of object: NSObject,
                             change: KeyValueChange) {
    guard let op = object as? NSOperation,
          let kind = change.kind,
          let oldValue = change.oldValue else {
      return
    }
    switch kind {
    case .setting:
      // Prior notifications do not provide a new value, just an old value,
      // i.e. the currently unchanged value of the observable property.
      if change.isPrior {
        operation(op, willChange: keyPath, oldValue: oldValue)
      } else {
        guard let newValue = change.newValue else {
          return
        }
        operation(op, didChange: keyPath, oldValue: oldValue, newValue: newValue)
      }
    default:
      break
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - OperationObserver

  /// Change observers see themselves being added to an operation. Start
  /// observing the operation immediately. This runs when the operation adds the
  /// observer.
  public func operation(_ op: NSOperation, willAddObserver observer: OperationObserver) {
    if observer === self {
      add(operation: op)
    }
  }

  public func operation(_ op: NSOperation, didAddObserver observer: OperationObserver) {}

  public func operation(_ op: NSOperation, willRemoveObserver observer: OperationObserver) {}

  public func operation(_ op: NSOperation, didRemoveObserver observer: OperationObserver) {
    if observer === self {
      remove(operation: op)
    }
  }

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

// Operations OperationChangeObserver.swift
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

  /// Observes a given operation. Observes all its key-value-observing compliant properties.
  public func observeOperation(op: NSOperation) {
    for keyPath in ["isCancelled",
                    "isExecuting",
                    "isFinished",
                    "isAsynchronous",
                    "isReady",
                    "dependencies",
                    "queuePriority",
                    "completionBlock"] {
      addObject(op, keyPath: keyPath, options: [.New, .Old, .Prior])
    }
  }

  func operation(op: NSOperation, willChange keyPath: String, oldValue: AnyObject) {
    switch keyPath {
    case "isCancelled":
      guard let oldValue = oldValue as? Bool else {
        break
      }
      operation(op, willChangeIsCancelled: oldValue)
    case "isExecuting":
      guard let oldValue = oldValue as? Bool else {
        break
      }
      operation(op, willChangeIsExecuting: oldValue)
    case "isFinished":
      guard let oldValue = oldValue as? Bool else {
        break
      }
      operation(op, willChangeIsFinished: oldValue)
    case "isReady":
      guard let oldValue = oldValue as? Bool else {
        break
      }
      operation(op, willChangeIsReady: oldValue)
    default:
      break
    }
  }

  func operation(op: NSOperation, didChange keyPath: String, oldValue: AnyObject, newValue: AnyObject) {
    switch keyPath {
    case "isCancelled":
      guard let oldValue = oldValue as? Bool,
            let newValue = newValue as? Bool else {
        break
      }
      operation(op, didChangeIsCancelled: newValue, wasCancelled: oldValue)
    case "isExecuting":
      guard let oldValue = oldValue as? Bool,
            let newValue = newValue as? Bool else {
        break
      }
      operation(op, didChangeIsExecuting: newValue, wasExecuting: oldValue)
    case "isFinished":
      guard let oldValue = oldValue as? Bool,
            let newValue = newValue as? Bool else {
        break
      }
      operation(op, didChangeIsFinished: newValue, wasFinished: oldValue)
    case "isReady":
      guard let oldValue = oldValue as? Bool,
            let newValue = newValue as? Bool else {
        break
      }
      operation(op, didChangeIsReady: newValue, wasReady: oldValue)
    default:
      break
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - KeyValueObserver

  override func observeValueForKeyPath(keyPath: String,
                                       ofObject object: NSObject,
                                                change: KeyValueChange) {
    guard let op = object as? NSOperation,
          let kind = change.kind,
          let oldValue = change.oldValue else {
      return
    }
    switch kind {
    case .Setting:
      if change.isPrior {
        operation(op, willChange: keyPath, oldValue: oldValue)
      }
      else {
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

}

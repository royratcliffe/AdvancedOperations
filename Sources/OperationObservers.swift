// AdvancedOperations OperationObservers.swift
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

/// Composite operation observer. Does nothing except relay operation
/// observations to zero or more *other* observers. Adding an observer to an
/// operation automatically constructs a composite observer if the operation has
/// more than one observer.
public class OperationObservers: OperationObserver {

  var observers = [OperationObserver]()

  public func add(observer newObserver: OperationObserver) {
    observers.append(newObserver)
  }

  /// Removes a given observer.
  /// - returns: The removed observer if currently registered as an
  ///   observer. Answers `nil` if not an observer.
  public func remove(observer oldObserver: OperationObserver) -> OperationObserver? {
    guard let index = observers.index(where: { $0 === oldObserver }) else {
      return nil
    }
    return observers.remove(at: index)
  }

  /// - returns: True if the sub-observer is currently registered, false if not.
  public func contains(observer: OperationObserver) -> Bool {
    return observers.contains(where: { $0 === observer })
  }

  //----------------------------------------------------------------------------
  // MARK: - OperationObserver

  public func operation(_ op: NSOperation, willAddObserver observer: OperationObserver) {
    for observer in observers {
      observer.operation(op, willAddObserver: observer)
    }
  }

  public func operation(_ op: NSOperation, didAddObserver observer: OperationObserver) {
    for observer in observers {
      observer.operation(op, didAddObserver: observer)
    }
  }

  public func operation(_ op: NSOperation, willRemoveObserver observer: OperationObserver) {
    for observer in observers {
      observer.operation(op, willRemoveObserver: observer)
    }
  }

  public func operation(_ op: NSOperation, didRemoveObserver observer: OperationObserver) {
    for observer in observers {
      observer.operation(op, didRemoveObserver: observer)
    }
  }

  public func operationWillStart(_ op: NSOperation) {
    for observer in observers {
      observer.operationWillStart(op)
    }
  }

  public func operationDidStart(_ op: NSOperation) {
    for observer in observers {
      observer.operationDidStart(op)
    }
  }

  public func operationWillExecute(_ op: NSOperation) {
    for observer in observers {
      observer.operationWillExecute(op)
    }
  }

  public func operationDidExecute(_ op: NSOperation) {
    for observer in observers {
      observer.operationDidExecute(op)
    }
  }

  public func operationWillCancel(_ op: NSOperation) {
    for observer in observers {
      observer.operationWillCancel(op)
    }
  }

  public func operationDidCancel(_ op: NSOperation) {
    for observer in observers {
      observer.operationDidCancel(op)
    }
  }

}

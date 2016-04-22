// Operations NSOperation+Observer.swift
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

var OperationObserverKey = 0

extension NSOperation {

  /// Supports an operation observer for every operation, for every
  /// `NSOperation` and all sub-classes. The operation retains the observer.
  public var observer: OperationObserver? {
    get {
      return objc_getAssociatedObject(self, &OperationObserverKey) as? OperationObserver
    }
    set(newObserver) {
      let observer = objc_getAssociatedObject(self, &OperationObserverKey) as? OperationObserver
      observer?.operationWillRemoveObserver(self)
      newObserver?.operationWillAddObserver(self)
      objc_setAssociatedObject(self, &OperationObserverKey, newObserver, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      newObserver?.operationDidAddObserver(self)
      observer?.operationDidRemoveObserver(self)
    }
  }

  /// Adds an observer to the operation. Sets the observer only, rather than
  /// adding, if there is currently no observer for this operation.
  ///
  /// Note, adding an observer sends will- and did-add observer
  /// notifications. The observer composite does not itself trigger observer
  /// notifications.
  public func addObserver(newObserver: OperationObserver) {
    if let observer = observer {
      newObserver.operationWillAddObserver(self)
      if let observers = observer as? OperationObservers {
        observers.addObserver(newObserver)
      }
      else {
        let observers = OperationObservers()
        observers.addObserver(observer)
        observers.addObserver(newObserver)
        self.observer = observer
      }
      newObserver.operationDidAddObserver(self)
    }
    else {
      observer = newObserver
    }
  }

  /// Removes an operation observer from this operation. The observer
  /// automatically receives notification of the removal, both before and after.
  public func removeObserver(oldObserver: OperationObserver) {
    guard let observer = observer else {
      return
    }
    if observer === oldObserver {
      self.observer = nil
    }
    else if let observers = observer as? OperationObservers {
      guard observers.containsObserver(oldObserver) else {
        return
      }
      oldObserver.operationWillRemoveObserver(self)
      observers.removeObserver(oldObserver)
      oldObserver.operationDidRemoveObserver(self)
    }
  }

}

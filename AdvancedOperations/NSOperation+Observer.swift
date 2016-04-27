// AdvancedOperations NSOperation+Observer.swift
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

var operationObserverKey = 0

extension NSOperation {

  /// Supports an operation observer for every operation, for every
  /// `NSOperation` and all sub-classes. The operation retains the observer.
  ///
  /// The observer setter performs no notifications about adding or removing
  /// observers. This is by design. If it did, setting a new observer means
  /// removing an old one if one already installed. Setting a new observer must
  /// remove any old one first. That observer will see itself being removed,
  /// even if not actually being removed from observations such as when a single
  /// observer becomes a composite observer. The single observer does not stop
  /// observing, it merely transfers to the composite.
  public var observer: OperationObserver? {
    get {
      return objc_getAssociatedObject(self, &operationObserverKey) as? OperationObserver
    }
    set(newObserver) {
      objc_setAssociatedObject(self, &operationObserverKey, newObserver, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

  /// Adds an observer to the operation. Sets the observer only, rather than
  /// adding, if there is currently no observer for this operation.
  ///
  /// Note, adding an observer sends will- and did-add observer
  /// notifications. The observer composite does not itself trigger observer
  /// notifications.
  public func addObserver(newObserver: OperationObserver) {
    newObserver.operationWillAddObserver(self)
    if let observer = observer {
      if let observers = observer as? OperationObservers {
        observers.addObserver(newObserver)
      } else {
        let observers = OperationObservers()
        observers.addObserver(observer)
        observers.addObserver(newObserver)
        self.observer = observers
      }
    } else {
      observer = newObserver
    }
    newObserver.operationDidAddObserver(self)
  }

  /// Removes an operation observer from this operation. The observer
  /// automatically receives notification of the removal, both before and after.
  public func removeObserver(oldObserver: OperationObserver) {
    guard let observer = observer else {
      return
    }
    if observer === oldObserver {
      oldObserver.operationWillRemoveObserver(self)
      self.observer = nil
      oldObserver.operationDidRemoveObserver(self)
    } else if let observers = observer as? OperationObservers {
      guard observers.containsObserver(oldObserver) else {
        return
      }
      oldObserver.operationWillRemoveObserver(self)
      observers.removeObserver(oldObserver)
      oldObserver.operationDidRemoveObserver(self)
    }
  }

}

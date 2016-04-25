// AdvancedOperations KeyValueObserver.swift
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

/// Observes key-value changes. Implements the key-value observing
/// protocol. Responds to key-value change notifications.
///
/// As a side-effect, the observer retains the observed objects. This retention
/// is unidirectional however because the objects do not automatically retain
/// the observer. Unless something retains the observer independently, it will
/// disappear when it goes out of scope. Do not forget to retain your observers
/// for as long as you want them to observe.
public class KeyValueObserver: NSObject {

  /// Retains the observed objects and observed key-paths. Used by the
  /// destructor to cleanly remove the observer from the key-value observation
  /// mechanism. Observer removal does not happen automatically or by default.
  ///
  /// Take care not to create retain cycles between the observer and the
  /// observed. The observer strongly retains the observed, so the observed
  /// should never do likewise to the observer. Otherwise, both will leak.
  var observing = [(object: NSObject, keyPath: String)]()

  deinit {
    for (object, keyPath) in observing {
      object.removeObserver(self, forKeyPath: keyPath)
    }
  }

  /// - returns: all the objects currently under observation.
  public var observingObjects: [NSObject] {
    return observing.map { (object, _) in
      return object
    }
  }

  /// - returns: all the key paths currently under observation.
  public var observingKeyPaths: [String] {
    return observing.map { (_, keyPath) in
      return keyPath
    }
  }

  /// Adds an object and key-path for observing. Note, you can add the same
  /// object and key-path pair more than once though it makes little sense to do
  /// so.
  public func addObject(object: NSObject, keyPath: String, options: NSKeyValueObservingOptions) {
    object.addObserver(self, forKeyPath: keyPath, options: options, context: nil)
    observing.append((object: object, keyPath: keyPath))
  }

  /// Removes an object from the key-value observer. Removes all its observing
  /// key paths. Use this method if you want to remove an object before the
  /// observer disappears. All observations automatically remove when the
  /// observer destructs.
  public func removeObject(object: NSObject) {
    let indexes = NSMutableIndexSet()
    for (index, objectAndKeyPath) in observing.enumerate() {
      if objectAndKeyPath.object === object {
        objectAndKeyPath.object.removeObserver(self, forKeyPath: objectAndKeyPath.keyPath)
        indexes.addIndex(index)
      }
    }
    indexes.sort().reverse().forEach { (index) in
      observing.removeAtIndex(index)
    }
  }

  /// Sub-classes override this method.
  func observeValueForKeyPath(keyPath: String, ofObject object: NSObject, change: KeyValueChange) {}

  //----------------------------------------------------------------------------
  // MARK: - NSObject Overrides

  // Observes key-value change notifications. Wraps the change in a key-value
  // change structure then passes the key-path, Next Step object and the change
  // wrapper to the method for override.
  public override func observeValueForKeyPath(keyPath: String?,
                                              ofObject object: AnyObject?,
                                                       change: [String: AnyObject]?,
                                                       context: UnsafeMutablePointer<Void>) {
    guard let keyPath = keyPath,
          let object = object as? NSObject,
          let change = KeyValueChange(change: change),
          let _ = change.kind else {
      return
    }
    observeValueForKeyPath(keyPath, ofObject: object, change: change)
  }

}

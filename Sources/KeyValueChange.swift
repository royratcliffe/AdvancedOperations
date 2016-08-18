// AdvancedOperations KeyValueChange.swift
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

/// Wraps a key-value change dictionary.
public struct KeyValueChange {

  let change: [NSKeyValueChangeKey: Any]

  /// Initialises the change wrapper using an optional change dictionary. Fails
  /// to wrap if the change dictionary does not exist. You get a `nil` change
  /// wrapper for a `nil` dictionary.
  public init?(change: [NSKeyValueChangeKey: Any]?) {
    guard let change = change else { return nil }
    self.change = change
  }

  /// - returns: a change kind enumerator value, one of the four: setting,
  ///   insertion, removal or replacement. Answers `nil` if the change
  ///   dictionary does not contain a change kind, or the change kind is not a
  ///   number, or that number does not match any of the enumerator values.
  public var kind: NSKeyValueChange? {
    guard let rawKind = change[NSKeyValueChangeKey.kindKey] as? NSNumber,
          let kind = NSKeyValueChange(rawValue: rawKind.uintValue) else {
      return nil
    }
    return kind
  }

  /// - returns: the new value, if there is one.
  public var newValue: Any? {
    return change[NSKeyValueChangeKey.newKey]
  }

  /// - returns: the old value, if there is one.
  public var oldValue: Any? {
    return change[NSKeyValueChangeKey.oldKey]
  }

  /// - returns: the indexes, if there are any.
  public var indexes: NSIndexSet? {
    return change[NSKeyValueChangeKey.indexesKey] as? NSIndexSet
  }

  /// - returns: if the change is a prior notification or not. Returns false if
  ///   prior notifications were not requested in the options when adding the
  ///   observer. In such cases when there is no is-prior indication, assumes
  ///   that the change is *not* a prior notification; priors must have an
  ///   is-prior key-boolean pair *and* the boolean must be true.
  public var isPrior: Bool {
    return change[NSKeyValueChangeKey.notificationIsPriorKey] as? Bool ?? false
  }

}

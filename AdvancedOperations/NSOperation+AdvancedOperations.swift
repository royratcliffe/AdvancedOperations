// AdvancedOperations NSOperation+AdvancedOperations.swift
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

extension NSOperation {

  /// - returns: All cancelled dependencies, or an empty array of operations if
  ///   no dependencies or none cancelled. This is useful to know when you want
  ///   to make an operation only continue if all its dependences finished
  ///   without cancellation.
  public var cancelledDependencies: [NSOperation] {
    return dependencies.filter { (op) -> Bool in
      return op.cancelled
    }
  }

  /// Adds zero or more dependent operations.
  public func addDependencies(dependencies: [NSOperation]) {
    for dependency in dependencies {
      addDependency(dependency)
    }
  }

  /// Sets up a completion block or adds a completion block if a previous
  /// completion block already exists for this operation.
  ///
  /// Next Step operations allow for only a single completion block. Adding
  /// _another_ completion block therefore sets up a third block which invokes the
  /// existing block first. So if a completion block already exists, adding
  /// actually replaces it with a new block which first invokes the existing
  /// block then invokes the new block, thereby chaining the blocks together. As
  /// a result, completion blocks always execute in the order added.
  public func addCompletionBlock(newCompletionBlock: Void -> Void) {
    if let oldCompletionBlock = completionBlock {
      completionBlock = {
        oldCompletionBlock()
        newCompletionBlock()
      }
    } else {
      completionBlock = newCompletionBlock
    }
  }

}

// AdvancedOperations OperationLogObserver.swift
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

/// Observes and logs operation change messages to the Apple system log facility.
///
/// The implementation converts the old and new values to strings using Swift
/// first, before sending the resulting strings to Cocoa's `NSLog`. The latter
/// does not accept `AnyObject` types in variadic argument lists.
public class OperationLogObserver: OperationChangeObserver {

  public override func operation(op: NSOperation,
                                 willChange keyPath: String,
                                            oldValue: AnyObject) {
    NSLog("%@ %@ will change %@", op, keyPath, "\(oldValue)")
  }

  public override func operation(op: NSOperation,
                                 didChange keyPath: String,
                                           oldValue: AnyObject,
                                           newValue: AnyObject) {
    NSLog("%@ %@ did change %@ -> %@", op, keyPath, "\(oldValue)", "\(newValue)")
  }

  public override func operationWillAddObserver(op: NSOperation) {
    NSLog("%@ will add observer %@", op, self)
    super.operationWillAddObserver(op)
  }

  public override func operationDidAddObserver(op: NSOperation) {
    super.operationDidAddObserver(op)
    NSLog("%@ did add observer %@", op, self)
  }

  public override func operationWillRemoveObserver(op: NSOperation) {
    NSLog("%@ will remove observer %@", op, self)
    super.operationWillRemoveObserver(op)
  }

  public override func operationDidRemoveObserver(op: NSOperation) {
    super.operationDidRemoveObserver(op)
    NSLog("%@ did remove observer %@", op, self)
  }

  public override func operationWillStart(op: NSOperation) {
    NSLog("%@ will start", op)
    super.operationWillStart(op)
  }

  public override func operationDidStart(op: NSOperation) {
    super.operationDidStart(op)
    NSLog("%@ did start", op)
  }

  public override func operationWillExecute(op: NSOperation) {
    NSLog("%@ will execute", op)
    super.operationWillExecute(op)
  }

  public override func operationDidExecute(op: NSOperation) {
    super.operationDidExecute(op)
    NSLog("%@ did execute", op)
  }

  public override func operationWillCancel(op: NSOperation) {
    NSLog("%@ will cancel", op)
    super.operationWillCancel(op)
  }

  public override func operationDidCancel(op: NSOperation) {
    super.operationDidCancel(op)
    NSLog("%@ did cancel", op)
  }

  public override func operation(op: NSOperation, willProduceOperation newOp: NSOperation) {
    NSLog("%@ will produce %@", op, newOp)
    super.operation(op, willProduceOperation: newOp)
  }

  public override func operation(op: NSOperation, didProduceOperation newOp: NSOperation) {
    super.operation(op, didProduceOperation: newOp)
    NSLog("%@ did produce %@", op, newOp)
  }

}
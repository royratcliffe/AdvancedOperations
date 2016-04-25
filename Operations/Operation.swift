// Operations Operation.swift
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

public class Operation: NSOperation {

  /// Issues a pre-start notification to the observer, or observers if a
  /// composite. Override this method in order to insert behaviour just before
  /// the operation starts. Do not forget to invoke the super-class method,
  /// otherwise observers will not see the pre-start notification. The operation
  /// starts when the method returns. This is therefore a useful place to set up
  /// the operation, e.g. by adding dependencies.
  func willStart() {
    observer?.operationWillStart(self)
  }

  func didStart() {
    observer?.operationDidStart(self)
  }

  func willExecute() {
    observer?.operationWillExecute(self)
  }

  func didExecute() {
    observer?.operationDidExecute(self)
  }

  func willCancel() {
    observer?.operationWillCancel(self)
  }

  func didCancel() {
    observer?.operationDidCancel(self)
  }

  func execute() {}

  //----------------------------------------------------------------------------
  // MARK: - NSOperation Overrides

  public override func start() {
    willStart()
    super.start()
    didStart()
  }

  public override func main() {
    guard !cancelled else {
      return
    }
    willExecute()
    execute()
    didExecute()
  }

  public override func cancel() {
    willCancel()
    super.cancel()
    didCancel()
  }

}

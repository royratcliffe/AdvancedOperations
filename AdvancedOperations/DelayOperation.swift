// AdvancedOperations DelayOperation.swift
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

/// Operation that delays for either a specified number of seconds (including
/// fractions of seconds) or until a specific date, before finishing. The
/// operation's initialiser accepts either an `NSTimeInterval` or an `NSDate` (a
/// date including a time).
public class DelayOperation: Operation {

  public enum Delay {

    case TimeInterval(NSTimeInterval)

    case Date(NSDate)

    /// - returns: Time interval in seconds from now. Converts the date to
    ///   seconds from now if the delay was initially expressed as an `NSDate`.
    ///
    /// Invoked by the operation's `execute()` method whenever the operation
    /// begins. Hence the time interval from "now" only begins whenever the
    /// operation starts. Other dependencies may delay the start of the delay.
    public var timeInterval: NSTimeInterval {
      switch self {
      case .TimeInterval(let timeInterval):
        return timeInterval
      case .Date(let date):
        return date.timeIntervalSinceNow
      }
    }

  }

  public let delay: Delay

  public init(delay: Delay) {
    self.delay = delay
    super.init()
  }

  public convenience init(timeInterval: NSTimeInterval) {
    self.init(delay: .TimeInterval(timeInterval))
  }

  public convenience init(date: NSDate) {
    self.init(delay: .Date(date))
  }

  // MARK: - Operation Overrides

  /// Delays finishing the operation until the time interval elapses. The delay
  /// interval must be positive. The operation finishes immediately if the
  /// interval is zero or negative.
  ///
  /// The implementation uses a semaphore to block the operation until the time
  /// elapses using GCD's `dispatch_after` function. This adds a tiny additional
  /// delay for the semaphore signalling block to run in the default
  /// quality-of-service dispatch queue.
  public override func execute() {
    let timeInterval = delay.timeInterval
    guard timeInterval > 0 else {
      return
    }
    let semaphore = dispatch_semaphore_create(0)
    let delta = Int64(timeInterval * NSTimeInterval(NSEC_PER_SEC))
    let when = dispatch_time(DISPATCH_TIME_NOW, delta)
    dispatch_after(when, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)) {
      dispatch_semaphore_signal(semaphore)
    }
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
  }

}

[![Build Status](https://travis-ci.org/royratcliffe/AdvancedOperations.svg?branch=master)](https://travis-ci.org/royratcliffe/AdvancedOperations)

# Advanced Operations

Some time ago, at WWDC 2015, Apple released a sample application called
Advanced NSOperations. You can find the accompanying video presentation on-line
[here](https://developer.apple.com/videos/play/wwdc2015/226/). The code itself
appears under Resources.

The presentation along with its sample-code contains some really useful ideas
for using operations to structure iOS applications (and Mac apps too). Although
Apple's tools and frameworks make it pretty easy to construct toy apps, serious
applications require some serious thought and take a considerable amount of
effort to accomplish effectively. iOS applications are really embedded
applications with restricted compute, memory and networking resources. The
under-utilised NSOperation class has been part of Apple's Foundation framework
for some time. Yet, it has not been clear exactly when and how to best use it;
and more importantly, when and how to use NSOperation instances *together* in
concert. The sample code includes some great ideas.

Trouble is, the Advanced NSOperations sample code can introduce some
complications and snags that can be very difficult to track down and debug. The
sample interweaves concepts such as conditions, producing operations, and
observing operation state changes. This AdvancedOperations framework
__decouples__ the concepts as much as possible in order to allow applications
to take what they need, and not take what they do not need. You might call this
AdvancedOperations decoupled, or AdvancedOperations-lite. Rather than
one-size-fits-all approach (actually, fits none) this framework provides a
'toolbox' of operations-related constructs. Take what you need, leave what you
do not.

## What Can It Do?

This framework introduces two new complementary classes, called `Operation` and `OperationQueue`. Both inherit from their Foundation-framework counterparts. See basic class diagram below.

![Basic Classes](http://royratcliffe.github.io/AdvancedOperations/images/basic-classes.svg "Basic Classes")

Notice that `AdvancedOperations.Operation` is a special kind of `Foundation.Operation`, where `Foundation.Operation` is the traditionally named `NSOperation`; and similarly for `AdvancedOperations.OperationQueue` and `Foundation.OperationQueue`. You add operations to an operation queue in order to execute them. Foundation operations run their `main()` method whereas Advanced operations run their `execute()` method. This is only in order that the Advanced operation can signal will-and-did start, execute and cancel events. Observers can watch Advanced operations transition between running states: from not started to started; from started to executing or cancelled; and finally from executing to finished or cancelled. Advanced operations only execute if not cancelled, and usually stop executing when cancelled.

### Observe Operations

You can observe operation events. You add an observer to an operation. All operations support observers, and that includes Foundation Operations.


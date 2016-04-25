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
observing operation state changes. This Operations framework __decouples__ the
concepts as much as possible in order to allow applications to take what they
need, and not take what they do not need. You might call this Operations
decoupled, or Operations-lite.


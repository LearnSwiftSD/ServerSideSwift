/*:
 [Home](Welcome) | [Previous](@previous) | [Next](@next)
 
 # What is Server Side Swift
 
 Server-side code is any code that runs on the server. This would include things like server applications, web apps, web API's, and others. Server Side Swift attempts to implement those things in the Swift programming language with the belief that it is an ideal language for the domain.
 
 When Swift was open sourced back in 2015 it also received official support for use on the Linux platform making it possible to run on servers. Since then IBM has been one of the largest proponents for using Swift on the server. They along with other core members from [Vapor](https://vapor.codes) (A Server Side Swift Framework) and Apple make up the SSWG ([Swift Server Work Group](https://swift.org/server/)). The SSWG's goal is to promote and steer efforts for developing and using Swift on the server.
 ___
 
 ![Backend Options](Options.png "Backend Options")
 ## What existing backend solutions are there?
 ### Cloud Kit (Apple)
 
 Apple has an excellent backend solution with a super easy to use API. Cloud Kit is pretty much already fully integrated into the iOS environment and domain objects can easily be converted and stored in the cloud. However, if you're looking to build a companion Android app you'll find that no SDK is available.
 
 ### Firebase (Google)
 
 Google also has an excellent backend solution. It already gets a plus with having SDK's available for both iOS and Android as well as a couple other platforms. The API is also really easy to use. However, you'll find that you'll have to structure your data in a flattened (Non-nested) way that may cause hardships depending on the use case. Also, Google has developed a reputation for collecting and using data in seemingly unethical ways causing many to second guess importing Google's frameworks into their project especially when considering GDPR compliance.
 
 ### Parse (*Facebook)
 
 I mention Parse here specifically because it's no longer an option. It was an excellent backend solution that many developers had built their apps on. However, when they were acquired and shut down by Facebook all those developers had the rug pulled from underneath them. Many considered the work to great to refactor and simply gave up on their apps. Some still speak about it like old war wounds. Third party SDK's are great but putting your full trust on them may end in providing you your own war stories.
 
 ### Node JS (Popular Server Side Framework)
 
 Writing your own server app is probably the most flexible option out there. You don't have to rely upon and potentially be disappointed by a third party SDK. You have the flexibility to model your data in ways that make the most sense for your use case. You can use a database of your choosing. The big downer of this option is that it often means learning an unknown language. Probably one of the more popular frameworks out there is Node JS, which uses JavaScript, an interpreted and dynamic language known to be fraught with run-time errors. It can be overwhelming to take on a new language, but it gets that much more difficult when you take into consideration that Server-Side development is a completely different paradigm from the mobile dev world.
 ___
 
 ![Swift & Server](WhyServerSideSwift.png "Why Server Side Swift")
 ## Why Swift on the Server?
 
 Server Side Swift fills in the void between easy to use, but restrictive and ultra-flexible, but a whole new overwhelming world to learn.
 
 ### Modern
 Swift, being a newcomer to the Server-Side world, has the opportunity to take advantage of many of the failings and lessons learned from the more established languages and frameworks without having to repeat the errors.
 
 ### Fast & Safe
 Swift is Staticly and Strongly-Typed and as such, it takes full advantage of those strong suits making it faster and safer than many other languages used in Server-Side development. With Swift, whole categories of errors that are common in dynamic languages become eliminated altogether.
 
 ### Known by iOS devs
 It's a familiar language to those in the iOS and MacOS communities and their knowledge is not wasted by having to pick up a new language.
 ___
 
 ## What Server Side Swift options are available?
 ### | Kitura
 ![Kitura Framework](Kitura.png "The Kitura Server Side Framework")
 
 Kitura is a Server Side Swift framework created by IBM. Kitura is a very well supported and liked framework. Amongst the Swift community, it is known as the more "enterprisey" framework, meaning that they're aiming to be stable and approachable for use with experienced server-side developers. That being said the framework is undoubtedly approachable by Swift developers who are new to the Server side world.
 
 ### | Perfect
 ![Perfect Framework](Perfect.png "The Perfect Server Side Framework")
 
 Perfect is a Server Side Swift framework created by a Canadian company named, PerfectlySoft. It's known to be a more technical/performance oriented framework which lends to it being less friendly to newcomers than other frameworks. Notably, they have an international following and quite a decent amount of Chinese documentation available.
 
 ### | Vapor
 ![Vapor Framework](Vapor.png "The Vapor Server Side Framework")
 
 Vapor is a Server Side Swift framework created by an iOS/Server developer, Tanner Nelson and his partner Logan Wright. It is the only one of the mentioned frameworks that is written entirely in Swift. It is probably the most popular of the Server Side Swift frameworks and is known to be the "Swiftiest" (following Swift conventions). It is known to quickly adopt Swift language changes (for better or for worse) and is built on top of Swift NIO.
 ___
 [Home](Welcome) | [Previous](@previous) | [Next](@next)
 */

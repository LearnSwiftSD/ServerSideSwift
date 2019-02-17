import Vapor

/// Returns a new `EventLoopFuture` that fires only when all the provided `futures` complete.
///
/// This function is useful for providing a sort of success completion signal to allow subsequent
/// work to be done.
///
/// The returned `EventLoopFuture` will fail as soon as a failure is encountered in any of the
/// `futures` provided. However, the failure will not occur until all preceding
/// `EventLoopFutures` have completed. At the point the failure is encountered, all subsequent
/// `EventLoopFuture` objects will no longer be waited for. This function therefore fails fast: once
/// a failure is encountered, it will immediately fail the overall EventLoopFuture.
///
/// - parameters:
///     - futures: An array of `EventLoopFuture<Void>` to wait for.
///     - worker: A reference to the chosen `EventLoop` where the work is to be done.
/// - returns: A new `EventLoopFuture<Void>` on the worker's `EventLoop`.
public func chain(_ futures: [EventLoopFuture<Void>], on worker: Worker) -> EventLoopFuture<Void> {
    let initialFuture = Future.map(on: worker) { () }
    let body = futures.reduce(initialFuture) { future1, future2 -> EventLoopFuture<Void> in
        let chainedFuture = future1.and(future2).map { (args: (Void, Void)) -> Void in
            let (_, nextValue): (Void, Void) = args
            initialFuture.eventLoop.assertInEventLoop()
            return nextValue
        }
        assert(chainedFuture.eventLoop === initialFuture.eventLoop)
        return chainedFuture
    }
    return body
}

extension EventLoopFuture {
    /// Passes the value to a new `EventLoopFuture` that fires only when the current future and all
    /// the provided `futures` have completed.
    ///
    /// This function is useful for providing a sort of success completion signal to allow subsequent
    /// work to be done on the original future's value.
    ///
    /// The returned `EventLoopFuture` will fail as soon as a failure is encountered in either the
    /// current future or any of the provide `futures`. However, the failure will not occur until all
    /// preceding `EventLoopFutures` have completed. At the point the failure is encountered, all
    /// subsequent `EventLoopFuture` objects will no longer be waited for. This function therefore
    /// fails fast: once a failure is encountered, it will immediately fail the overall EventLoopFuture.
    ///
    /// - parameters:
    ///     - futures: An array of `EventLoopFuture<Void>` to wait for.
    /// - returns: A new `EventLoopFuture` containing the value of the original future.
    public func relay(through futures: [EventLoopFuture<Void>]) -> EventLoopFuture<T> {
        let body = futures.reduce(self) { future1, future2 -> EventLoopFuture<T> in
            let chainedFuture = future1.and(future2).map { (args: (T, Void)) -> T in
                let (passThrough, _) = args
                self.eventLoop.assertInEventLoop()
                return passThrough
            }
            assert(chainedFuture.eventLoop === self.eventLoop)
            return chainedFuture
        }
        return body
    }
    
    /// A combination of `map` and `chain` where you provide a closure that maps the existing value
    /// of the `EventLoopFuture` to an `Array<EventLoopFuture<Void>>` which then fires only when all the
    /// provided `EventLoopFuture<Void>`s complete.
    ///
    /// This function is useful for providing a sort of success completion signal to allow subsequent
    /// work to be done.
    ///
    /// The returned `EventLoopFuture` will fail as soon as a failure is encountered in any of the
    /// `futures` provided. However, the failure will not occur until all preceding
    /// `EventLoopFutures` have completed. At the point the failure is encountered, all subsequent
    /// `EventLoopFuture` objects will no longer be waited for. This function therefore fails fast: once
    /// a failure is encountered, it will immediately fail the overall EventLoopFuture.
    ///
    /// - parameters:
    ///     - callback: A closure that maps the existing value of the `EventLoopFuture` to an
    ///         `Array<EventLoopFuture<Void>>`
    /// - returns: A new `EventLoopFuture<Void>` on the existing `EventLoop`.
    public func chainMap(_ callback: @escaping (Expectation) throws -> [EventLoopFuture<Void>]) -> EventLoopFuture<Void> {
        return map(to: [EventLoopFuture<Void>].self, callback)
            .flatMap { futures in
                let initialFuture = Future.map(on: self.eventLoop) { () }
                let body = futures.reduce(initialFuture) { future1, future2 -> EventLoopFuture<Void> in
                    let chainedFuture = future1.and(future2).map { (args: (Void, Void)) -> Void in
                        let (_, nextValue): (Void, Void) = args
                        self.eventLoop.assertInEventLoop()
                        return nextValue
                    }
                    assert(chainedFuture.eventLoop === self.eventLoop)
                    return chainedFuture
                }
                return body
        }
    }
    
}

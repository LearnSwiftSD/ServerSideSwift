import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    let swiftCastController = SwiftCastController()
    let hostController = HostController()
    
    try router.register(collection: swiftCastController)
    try router.register(collection: hostController)
    
}

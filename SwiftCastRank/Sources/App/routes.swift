import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    #warning("TODO: Setup your HostController and register it")
    let swiftCastController = SwiftCastController()
    
    try router.register(collection: swiftCastController)
    
}

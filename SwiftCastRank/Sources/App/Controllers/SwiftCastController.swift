import Fluent
import Vapor
import FluentSQLite

struct SwiftCastController: RouteCollection {
    
    func boot(router: Router) throws {
        let swiftCastRoute = router.grouped("api", "swiftCast")
        
        swiftCastRoute.get(use: getSwiftCasts)
        swiftCastRoute.get(SwiftCast.parameter, use: getSwiftCast)
        swiftCastRoute.get(SwiftCast.parameter, "swifties", use: getSwifties)
        swiftCastRoute.get("topRated", use: getTopSwiftCasts)
        
        swiftCastRoute.post(use: addSwiftCast)
        swiftCastRoute.post(SwiftCast.parameter, "swifty", use: addSwifty)
        
        swiftCastRoute.delete(SwiftCast.parameter, use: deleteSwiftCast)
        swiftCastRoute.delete("swifty", Swifty.parameter, use: deleteSwifty)
    }
    
    func getSwiftCasts(_ req: Request) throws -> Future<[SwiftCast]> {
        return SwiftCast.query(on: req).all()
    }
    
    func getSwiftCast(_ req: Request) throws -> Future<SwiftCast> {
        return try req.parameters.next(SwiftCast.self)
    }
    
    func getSwifties(_ req: Request) throws -> Future<[Swifty]> {
        return try req.parameters.next(SwiftCast.self)
            .flatMap(to: [Swifty].self) { swiftCast in
                return try swiftCast.swifties.query(on: req).all()
        }
    }
    
    func getTopSwiftCasts(_ req: Request) throws -> Future<[SwiftCast]> {
        return SwiftCast.query(on: req)
            .sort(\.swiftiesCount, .descending)
            .range(..<5).all()
    }
    
    func addSwiftCast(_ req: Request) throws -> Future<SwiftCast> {
        return try req.content.decode(SwiftCastData.self)
            .map { SwiftCast(name: $0.name) }
            .flatMap { $0.save(on: req) }
    }
    
    func addSwifty(_ req: Request) throws -> Future<Swifty> {
        let swiftCast = try req.parameters.next(SwiftCast.self)
        let swiftyData = try req.content.decode(SwiftyData.self)
        return flatMap(to: Swifty.self, swiftCast, swiftyData) { aSwiftCast, aSwiftyData in
            let (name, id) = try (aSwiftyData.giverName, aSwiftCast.requireID())
            let swifty = Swifty(giverName: name, recipientID: id)
            return swifty.save(on: req)
        }
    }
    
    func deleteSwiftCast(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(SwiftCast.self)
            .flatMap { $0.delete(on: req) }
            .transform(to: .accepted)
    }
    
    func deleteSwifty(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Swifty.self)
            .flatMap { $0.delete(on: req) }
            .transform(to: .accepted)
    }
    
}

extension SwiftCastController {
    
    struct SwiftCastData: Content {
        let name: String
    }
    
    struct SwiftyData: Content {
        let giverName: String
    }
    
}

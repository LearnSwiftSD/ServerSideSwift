import FluentSQLite
import Vapor

struct HostController: RouteCollection {
    
    func boot(router: Router) throws {
        let hostRoute = router.grouped("api", "host")
        
        hostRoute.get(use: getAllHosts)
        hostRoute.get(Host.parameter, use: getHost)
        hostRoute.get("search", use: searchHosts)
        hostRoute.get(Host.parameter, "swiftCasts", use: getSwiftCast)
        
        hostRoute.post(use: addHost)
        hostRoute.post(Host.parameter, "swiftCasts", SwiftCast.parameter, use: addSwiftCast)
        
        hostRoute.delete(Host.parameter, use: deleteHost)
    }
    
    func getAllHosts(_ req: Request) throws -> Future<[Host]> {
        return Host.query(on: req).all()
    }
    
    func getHost(_ req: Request) throws -> Future<Host> {
        return try req.parameters.next(Host.self)
    }
    
    func searchHosts(_ req: Request) throws -> Future<[Host]> {
        guard let searchTerm = req.query[String.self, at: "searchTerm"] else {
            throw Abort(.badRequest, reason: "Missing name in search request")
        }
        
        return try req.connectionPool(to: .sqlite)
            .select().all().from(Host.self)
            .where(\Host.name, .like, "%\(searchTerm)%")
            .all(decoding: Host.self)
    }
    
    func getSwiftCast(_ req: Request) throws -> Future<[SwiftCast]> {
        return try req.parameters.next(Host.self)
            .flatMap(to: [SwiftCast].self) { host in
                return try host.swiftCasts.query(on: req).all()
        }
    }
    
    func addHost(_ req: Request) throws -> Future<Host> {
        return try req.content.decode(HostData.self)
            .flatMap(to: Host.self) { hostData in
                let host = Host(name: hostData.name)
                return host.save(on: req)
        }
    }
    
    func addSwiftCast(_ req: Request) throws -> Future<HTTPStatus> {
        let host = try req.parameters.next(Host.self)
        let swiftCast = try req.parameters.next(SwiftCast.self)
        return flatMap(to: HTTPStatus.self, host, swiftCast) { host, swiftCast in
            let pivot = try SwiftCastHostPivot(swiftCast.requireID(), host.requireID())
            return pivot.save(on: req).transform(to: .created)
        }
    }
    
    func deleteHost(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters
            .next(Host.self)
            .delete(on: req)
            .transform(to: .accepted)
    }
    
}

extension HostController {
    
    struct HostData: Content {
        let name: String
    }
    
}

import FluentSQLite
import Vapor

struct HostController: RouteCollection {
    
    func boot(router: Router) throws {
        let hostRoute = router.grouped("api", "host")
        
        #warning("TODO: Register Host routes here")
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
    
    #warning("TODO: Implement remaining Host routes")
    
}

#warning("TODO: Create HostData conforming to Content")

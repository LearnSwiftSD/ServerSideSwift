import FluentSQLite
import Vapor

final class Host: SQLiteModel {
    
    var id: Int?
    
    var name: String
    
    var info: HostInfo
    
    init(name: String) {
        self.name = name
        self.info = HostInfo(swiftCasts: [:])
    }
    
    var swiftCasts: Siblings<Host, SwiftCast, SwiftCastHostPivot> {
        return siblings()
    }
    
    func willCreate(on conn: SQLiteConnection) throws -> EventLoopFuture<Host> {
        return Host.query(on: conn)
            .filter(\.name == name).first()
            .map(to: Host?.self) { host in
                let exists = "Already exists!"
                if host != nil { throw Abort(.conflict, reason: exists) }
                return host
            }
            .transform(to: self)
        
    }
    
    func willDelete(on conn: SQLiteConnection) throws -> EventLoopFuture<Host> {
        return try SwiftCastHostPivot.query(on: conn)
            .filter(\.hostID == self.requireID()).all()
            .chainMap { $0.map { $0.delete(on: conn) } }
            .transform(to: self)
    }
    
}

extension Host: Content {}
extension Host: Parameter {}
extension Host: Migration {}

struct HostInfo: SQLiteJSONType {
    var swiftCasts: [Int: String]
}


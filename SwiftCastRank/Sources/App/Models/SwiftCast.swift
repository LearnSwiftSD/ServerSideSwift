import FluentSQLite
import Vapor

final class SwiftCast: SQLiteModel {
    
    var id: Int?
    
    var name: String
    
    var swiftiesCount: Int = 0
    
    var info: SwiftCastInfo
    
    init(name: String) {
        self.name = name
        self.info = SwiftCastInfo(
            swifties: [:],
            hosts: [:]
        )
    }
    
    var swifties: Children<SwiftCast, Swifty> {
        return children(\.ownerID)
    }
    
    var hosts: Siblings<SwiftCast, Host, SwiftCastHostPivot> {
        return siblings()
    }
    
    func willDelete(on conn: SQLiteConnection) throws -> EventLoopFuture<SwiftCast> {
        
        let deleteSwifties = try swifties.query(on: conn).delete()
        
        let deleteHostRelationships = try SwiftCastHostPivot.query(on: conn)
            .filter(\.swiftCastID == self.requireID()).all()
            .chainMap { $0.map { $0.delete(on: conn) } }
        
        return chain([deleteSwifties, deleteHostRelationships], on: conn)
            .transform(to: self)
    }
    
}

extension SwiftCast: Content {}
extension SwiftCast: Parameter {}
extension SwiftCast: Migration {}

struct SwiftCastInfo: SQLiteJSONType {
    
    var swifties: [Int: String]
    var hosts: [Int: String]
    
}


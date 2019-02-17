import FluentSQLite
import Vapor

final class SwiftCastHostPivot: SQLitePivot, Migration {
    
    typealias Left = SwiftCast
    typealias Right = Host
    
    var id: Int?
    var swiftCastID: SwiftCast.ID
    var hostID: Host.ID
    
    static let leftIDKey: LeftIDKey = \.swiftCastID
    static let rightIDKey: RightIDKey = \.hostID
    
    init(_ swiftCastID: SwiftCast.ID, _ hostID: Host.ID) {
        self.swiftCastID = swiftCastID
        self.hostID = hostID
    }
    
    func didCreate(on conn: SQLiteConnection) throws -> EventLoopFuture<SwiftCastHostPivot> {
        
        let swiftCast = SwiftCast.query(on: conn).filter(\.id == swiftCastID).first()
        let host = Host.query(on: conn).filter(\.id == hostID).first()
        let futurePivot = Future.map(on: conn) { self }
        
        return flatMap(to: SwiftCastHostPivot.self, swiftCast, host) { aSwiftCast, aHost in
            guard let aSwiftCast = aSwiftCast, let aHost = aHost else { return futurePivot }
            try aSwiftCast.info.hosts[aHost.requireID()] = aHost.name
            try aHost.info.swiftCasts[aSwiftCast.requireID()] = aSwiftCast.name
            
            return chain([
                aSwiftCast.save(on: conn).transform(to: ()),
                aHost.save(on: conn).transform(to: ())
                ], on: conn).transform(to: self)
        }
    }
    
    func willDelete(on conn: SQLiteConnection) throws -> EventLoopFuture<SwiftCastHostPivot> {
        
        let swiftCast = SwiftCast.query(on: conn).filter(\.id == swiftCastID).first()
        let host = Host.query(on: conn).filter(\.id == hostID).first()
        let futurePivot = Future.map(on: conn) { self }
        
        return flatMap(to: SwiftCastHostPivot.self, swiftCast, host) { aSwiftCast, aHost in
            guard let aSwiftCast = aSwiftCast, let aHost = aHost else { return futurePivot }
            try aSwiftCast.info.hosts.removeValue(forKey: aHost.requireID())
            try aHost.info.swiftCasts.removeValue(forKey:  aSwiftCast.requireID())
            
            return chain([
                aSwiftCast.save(on: conn).transform(to: ()),
                aHost.save(on: conn).transform(to: ())
                ], on: conn).transform(to: self)
            
        }
    }
    
}

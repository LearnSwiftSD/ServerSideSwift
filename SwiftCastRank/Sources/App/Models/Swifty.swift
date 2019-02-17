import FluentSQLite
import Vapor

final class Swifty: SQLiteModel {
    
    var id: Int?
    
    var giverName: String
    
    var ownerID: SwiftCast.ID
    
    init(giverName: String, recipientID: SwiftCast.ID) {
        self.giverName = giverName
        self.ownerID = recipientID
    }
    
    var owner: Parent<Swifty, SwiftCast> {
        return parent(\.ownerID)
    }
    
    func didCreate(on conn: SQLiteConnection) throws -> EventLoopFuture<Swifty> {
        let futureSwifty = Future.map(on: conn) { self }
        let swiftCast = owner.get(on: conn)
        
        return flatMap(to: Swifty.self, futureSwifty, swiftCast) { thisSwifty, aSwiftCast in
            aSwiftCast.swiftiesCount += 1
            try aSwiftCast.info.swifties[thisSwifty.requireID()] = thisSwifty.giverName
            return aSwiftCast.save(on: conn).flatMap(to: Swifty.self) { _ in
                return Future.map(on: conn) { thisSwifty }
            }
        }
    }
    
    func willDelete(on conn: SQLiteConnection) throws -> EventLoopFuture<Swifty> {
        let futureSwifty = Future.map(on: conn) { self }
        let swiftCast = owner.get(on: conn)
        
        return flatMap(to: Swifty.self, futureSwifty, swiftCast) { thisSwifty, aSwiftCast in
            let removedSwifty = try aSwiftCast.info.swifties.removeValue(forKey: thisSwifty.requireID())
            guard aSwiftCast.swiftiesCount > 0, removedSwifty != nil else { return futureSwifty }
            aSwiftCast.swiftiesCount -= 1
            return aSwiftCast.save(on: conn).flatMap(to: Swifty.self) { _ in
                return Future.map(on: conn) { thisSwifty }
            }
        }
    }
    
}

extension Swifty: Content {}
extension Swifty: Parameter {}
extension Swifty: Migration {}

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
    
    #warning("TODO: Setup property `swiftCasts` siblings")
    
    #warning("TODO: Setup your willCreate/didCreate life cycle methods")
    
}

extension Host: Content {}
extension Host: Parameter {}
extension Host: Migration {}

struct HostInfo: SQLiteJSONType {
    var swiftCasts: [Int: String]
}


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

#warning("TODO: Setup conformances")

extension Host: Migration {}

struct HostInfo: SQLiteJSONType {
    var swiftCasts: [Int: String]
}


import FluentSQLite
import Vapor

/// Called before your application initializes.
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
    ) throws {
    
    // Register providers first
    try services.register(FluentSQLiteProvider())
    
    //Directory services
    let directoryConfig = DirectoryConfig.detect()
    services.register(directoryConfig)
    
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)
    
    // Configure a SQLite database
    let sqlite = try SQLiteDatabase(storage: .file(path: "\(directoryConfig.workDir)swiftCastRank.db"))
    
    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)
    
    // Configure migrations
    var migrations = MigrationConfig()
    
    migrations.add(model: SwiftCast.self, database: .sqlite)
    migrations.add(model: Host.self, database: .sqlite)
    migrations.add(model: Swifty.self, database: .sqlite)
    migrations.add(model: SwiftCastHostPivot.self, database: .sqlite)
    
    services.register(migrations)
}

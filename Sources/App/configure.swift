import Vapor
import Leaf
import FluentPostgreSQL

public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    let myService = EngineServerConfig.default(port: 8006)
    services.register(myService)

    try services.register(LeafProvider())
    try services.register(FluentPostgreSQLProvider())

    config.prefer(LeafRenderer.self, for: TemplateRenderer.self)

    let postgresqlConfig = PostgreSQLDatabaseConfig(
        hostname: "127.0.0.1",
        port: 5432,
        username: "martinlasek",
        database: "mycooldb",
        password: nil
    )
    services.register(postgresqlConfig)

    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .psql)
    services.register(migrations)
}

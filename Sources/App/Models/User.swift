import FluentPostgreSQL
import Vapor

final class User: PostgreSQLModel {
    var id: Int?
    var username: String
    init(id: Int? = nil, username: String) {
        self.id = id
        self.username = username
    }
}
extension User: Content {}
extension User: Migration {}

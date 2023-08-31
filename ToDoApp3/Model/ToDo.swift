
import Foundation

struct ToDo: Codable {
    var priority: Int
    var id: Int
    var category: String
    var title: String
    var done: Bool
    var createdAt: Date
}

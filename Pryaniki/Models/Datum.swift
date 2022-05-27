import Foundation

struct Datum: Codable, Hashable {
    var text: String?
    var url: String?
    var selectedId: Int?
    var variants: [Variant]?
}

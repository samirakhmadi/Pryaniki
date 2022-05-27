import Foundation

enum SampleError: LocalizedError {
    case `default`(description: String? = nil)
    
    var errorDescription: String? {
        switch self {
        case let .default(description):
            return description ?? "Something went wrong"
        }
    }
}

import Combine
import Foundation

protocol SampleServiceProtocol {
    func fetchSample() -> AnyPublisher<Sample, SampleError>
}

final class SampleService: SampleServiceProtocol {
    
    private let url = URL(string: "https://pryaniky.com/static/json/sample.json")!
    
    func fetchSample() -> AnyPublisher<Sample, SampleError> {
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: Sample.self, decoder: JSONDecoder())
            .mapError { .default(description: $0.localizedDescription) }
            .eraseToAnyPublisher()
    }
    
}



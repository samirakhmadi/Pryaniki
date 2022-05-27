import Combine

final class SampleViewModel: ObservableObject {
    
    enum Cell: String {
        case text = "hz"
        case image = "picture"
        case selector = "selector"
    }
    
    @Published private(set) var itemViewModels: [SampleData] = []
    @Published var error: SampleError?
    @Published private(set) var isLoading = false
    
    private let sampleService: SampleServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    
    init(sampleService: SampleServiceProtocol = SampleService()) {
        self.sampleService = sampleService
        observeSample()
    }
    
    private func observeSample() {
        isLoading = true
        sampleService.fetchSample()
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                switch completion {
                case .finished:
                    print("finished")
                case let .failure(error):
                    self.error = error
                }
                
            } receiveValue: { [weak self] sample in
                guard let self = self else { return }
                
                self.isLoading = false
                self.error = nil
                
                sample.view.forEach { view in
                    guard let sampleData = sample.data.first(where: { $0.name == view }) else { return }
                    self.itemViewModels.append(sampleData)
                }
            }
            .store(in: &cancellables)
    }
    
    
    
    
}

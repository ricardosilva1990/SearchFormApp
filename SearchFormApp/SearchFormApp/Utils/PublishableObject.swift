import Combine
import SwiftUI

class PublishableObject<Wrapper: Publisher>: LoadableObject {
    @Published private(set) var state = LoadingState<Wrapper.Output>.idle
    private let publisher: Wrapper

    init(publisher: Wrapper) {
        self.publisher = publisher
    }
    
    private var cancellables = Set<AnyCancellable>()

    func load() {
        state = .loading

        publisher
            .receive(on: DispatchQueue.main)
            .map(LoadingState.loaded)
            .catch { error in
                Just(LoadingState.failed(error))
            }
            .sink { [weak self] state in
                self?.state = state
            }
            .store(in: &cancellables)
    }
}

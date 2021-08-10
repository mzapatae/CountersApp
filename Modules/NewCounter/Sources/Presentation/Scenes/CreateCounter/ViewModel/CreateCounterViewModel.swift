import Counter
import Combine
import Resolver
import Foundation
import AltairMDKCommon

struct ViewState {
    var exception: Exception? = .none
    var isCreated: Bool = false
    var isCreating: Bool = false
}

protocol CreateCounterViewModelProtocol {
    var statePublisher: Published<ViewState>.Publisher { get }
    var coordinator: CreateCounterFlow? { get set }
    
    func createCouter(title: String)
}

final class CreateCounterViewModel: CreateCounterViewModelProtocol {
    var statePublisher: Published<ViewState>.Publisher { $viewState }
    var coordinator: CreateCounterFlow?
    
    @Injected private var counterStore: CounterStore
    @Published private var viewState = ViewState()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupViewState()
    }
    
    func createCouter(title: String) {
        counterStore.trigger(.createCounter(title: title))
    }
    
}

private extension CreateCounterViewModel {
    
    func setupViewState() {
        counterStore.$state.map { state in
            let exception = state.exception
            var isCreating = false
            if case .whenCreateCounter = state.runningSideEffect {
                isCreating = true
            } else {
                isCreating = false
            }
            let isCreated = !state.counters.isEmpty
            return ViewState(exception: exception, isCreated: isCreated, isCreating: isCreating)
        }
        .assignNoRetain(to: \.viewState, on: self)
        .store(in: &cancellables)
    }
    
}

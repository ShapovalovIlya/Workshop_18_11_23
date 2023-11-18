//
//  EnvironmentStore.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 18.11.2023.
//

import Foundation
import Redux

@dynamicMemberLookup
final class EnvironmentStore: ObservableObject {
   @Published private(set) var state: AppState
    
    let store: Store<AppState>
    
    private lazy var asObserver: Observer<AppState> = .init(
        queue: .main
    ) { [weak self] state in
        guard let self else { return .dead }
        self.state = state
        return .active
    }
    
    init(store: Store<AppState>) {
        self.store = store
        self.state = store.state
        store.subscribe(asObserver)
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<Store<AppState>, T>) -> T {
        store[keyPath: keyPath]
    }
}


//
//  Workshop_18_11_23App.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 18.11.2023.
//

import SwiftUI
import Redux
import OSLog

extension Logger {
    static let system = Self(
        subsystem: Bundle.main.bundleIdentifier!,
        category: "System"
    )
}

@main
struct Workshop_18_11_23App: App {
    let store: Store<AppState>
    
    //MARK: - Body
    var body: some Scene {
        WindowGroup {
            StoreProvider(store: store) {
                RootConnector()
            }
        }
    }
    
    //MARK: - init(_:)
    init() {
        store = Store(initial: AppState()) { state, action in
            Logger.system.debug("Store: \(String(describing: action), align: .right(columns: 10))")
            state.reduce(action)
        }
        
        let sessionDriver = SessionDriver(store: store, logger: .system)
        let networkDriver = NetworkDriver(store: store, logger: .system)
        
        store.subscribe(sessionDriver.asObserver)
        store.subscribe(networkDriver.asObserver)
    }
}

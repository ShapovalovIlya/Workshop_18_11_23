//
//  SessionDriver.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 26.11.2023.
//

import Foundation
import Networking
import Endpoint
import OSLog
import Redux

final class SessionDriver {
    //MARK: - Private properties
    private let `operator`: NetworkOperator
    private let store: Store<AppState>
    private let queue: DispatchQueue
    private var logger: Logger?
    
    private(set) lazy var asObserver: Observer<AppState> = .init(queue: queue) { state in
        self.process(state)
        return .active
        }
    
    //MARK: - init(_:)
    init(
        queue: DispatchQueue = .init(label: "NetworkDriver"),
        store: Store<AppState>,
        logger: Logger? = nil
    ) {
        self.operator = .init(queue: queue, logger: logger)
        self.store = store
        self.queue = queue
        self.logger = logger
        
        logger?.debug(#function)
    }
    
}

private extension SessionDriver {
    func process(_ state: AppState) {
        switch state.session {
        case .login(let id):
            print("Successfully get session!")
            store.dispatch(SessionActions.SessionSuccess(id))
            
        default: return
        }
    }
}

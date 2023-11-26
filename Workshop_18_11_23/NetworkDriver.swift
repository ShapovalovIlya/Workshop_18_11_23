//
//  NetworkDriver.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 26.11.2023.
//

import Foundation
import Networking
import Endpoint
import Redux
import OSLog

final class NetworkDriver {
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

private extension NetworkDriver {
    func process(_ state: AppState) {
        guard case .loginSuccess(let id) = state.session else { return }
        
        `operator`.process {
            NetworkOperator.Request(
                id: id,
                request: Endpoint.posts.request(),
                handler: handlePosts(store)
            )
        }
    }
    
    func handlePosts(_ store: Store<AppState>) -> (Result<NetworkOperator.Request.Response, Error>) -> Void {
        { result in
            switch result.map(\.data) {
            case .success(let data):
                guard let newPosts = try? JSONDecoder().decode([Post].self, from: data) else {
                    store.dispatch(HomeActions.PostsRequestFailed(CocoaError(.fileNoSuchFile)))
                    return
                }
                store.dispatch(HomeActions.UpdatePosts(newPosts))
                
            case .failure(let error):
                store.dispatch(HomeActions.PostsRequestFailed(error))
            }
        }
    }
}


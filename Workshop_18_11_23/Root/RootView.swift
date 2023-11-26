//
//  RootView.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 18.11.2023.
//

import SwiftUI

struct RootView<L: View, H: View>: View, Equatable {
    let state: State
    let login: () -> L
    let home: () -> H
    
    private let transition: AnyTransition = .slide
    
    var body: some View {
        NavigationView {
            switch state {
            case .login:
                login()
                    .transition(transition)
            case .home:
                home()
                    .transition(transition)
            }
        }
    }
    
    static func == (lhs: RootView<L,H>, rhs: RootView<L,H>) -> Bool {
        lhs.state == rhs.state
    }
    
    enum State: Equatable {
        case login
        case home
    }
}

struct RootConnector: Connector {
    func map(_ store: EnvironmentStore) -> some View {
        let rootState: RootView<LoginConnector, HomeConnector>.State
        switch store.session {
        case .loginSuccess: rootState = .home
        default: rootState = .login
        }
        
        return RootView(
            state: rootState,
            login: LoginConnector.init,
            home: HomeConnector.init
        )
        .equatable()
    }
}

#Preview {
    RootView(
        state: .login,
        login: EmptyView.init,
        home: EmptyView.init
    )
}

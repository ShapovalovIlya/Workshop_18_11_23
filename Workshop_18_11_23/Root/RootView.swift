//
//  RootView.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 18.11.2023.
//

import SwiftUI

struct RootView<V: View>: View {
    let state: State
    let login: () -> V
    let home: () -> V
    
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
    
    enum State: Equatable {
        case login
        case home
    }
}



#Preview {
    RootView(
        state: .login,
        login: EmptyView.init,
        home: EmptyView.init
    )
}

//
//  AppState.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 18.11.2023.
//

import Foundation
import Redux

struct AppState: Reducer {
    var login: LoginState
    var session: SessionState
    var home: HomeState
    
    init() {
        self.login = LoginState()
        self.session = SessionState()
        self.home = HomeState()
    }
    
    mutating func reduce(_ action: Action) {
        login.reduce(action)
        session.reduce(action)
        home.reduce(action)
    }
}

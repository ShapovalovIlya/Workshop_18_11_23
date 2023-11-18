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
    
    init() {
        self.login = LoginState()
    }
    
    mutating func reduce(_ action: Action) {
        login.reduce(action)
    }
}

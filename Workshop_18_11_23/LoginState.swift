//
//  LoginState.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 18.11.2023.
//

import Foundation
import Redux

struct LoginState: Reducer {
    var login: String
    var password: String
    
    var isValid: Bool {
        login.count > 3 && password.count > 3
    }
    
    init(
        login: String = .init(),
        password: String = .init()
    ) {
        self.login = login
        self.password = password
    }
    
    mutating func reduce(_ action: Action) {
        switch action {
        case let action as LoginActions.UpdateLogin:
            login = action.login
            
        case let action as LoginActions.UpdatePassword:
            password = action.password
            
        default: return
        }
    }
}

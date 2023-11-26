//
//  SessionState.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 26.11.2023.
//

import Foundation
import Redux

enum SessionState: Equatable, Reducer {
    case none
    case login(UUID)
    case loginSuccess(UUID)
    case loginFailed
    
    init() { self = .none }
    
    mutating func reduce(_ action: Action) {
        switch action {
        case is LoginActions.Login:
            self = .login(UUID())
            
        case let action as SessionActions.SessionSuccess:
            self = .loginSuccess(action.token)
            
        default: return
        }
    }
}

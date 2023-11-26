//
//  LoginActions.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 18.11.2023.
//

import Foundation
import Redux

enum LoginActions {
    struct UpdateLogin: Action {
        let login: String
        init(_ login: String) { self.login = login }
    }
    
    struct UpdatePassword: Action {
        let password: String
        init(_ password: String) { self.password = password }
    }
    
    struct Login: Action {}
}

//
//  LoginView.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 18.11.2023.
//

import SwiftUI

struct LoginView: View {
    @Binding var login: String
    @Binding var password: String
    let action: ActionState
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Hello!")
            TextField("Login", text: $login)
                .padding(.horizontal)
                .textFieldStyle(.roundedBorder)
            TextField("Password", text: $password)
                .padding(.horizontal)
                .textFieldStyle(.roundedBorder)
            Button("Sign in", action: tapAction)
            .buttonStyle(.bordered)
            .disabled(action.disabled)
        }
        .padding()
    }
    
    func tapAction() {
        guard case .active(let command) = action else {
            return
        }
        command()
    }
    
    typealias Command = () -> Void
    
    enum ActionState: Equatable {
        case active(Command)
        case inactive
        
        var disabled: Bool {
            self == .inactive
        }
        
        static func == (lhs: ActionState, rhs: ActionState) -> Bool {
            String(describing: lhs) == String(describing: rhs)
        }
    }
}

struct LoginConnector: Connector {
    func map(_ store: EnvironmentStore) -> some View {
        LoginView(
            login: Binding(
                get: { store.login.login },
                set: { store.store.dispatch(LoginActions.UpdateLogin($0)) }
            ),
            password: Binding(
                get: { store.login.password },
                set: { store.store.dispatch(LoginActions.UpdatePassword($0)) }
            ),
            action: store.login.isValid
            ? .active({ store.store.dispatch(LoginActions.Login()) })
            : .inactive
        )
    }
}

#Preview {
    LoginView(
        login: .constant("Ilia"),
        password: .constant("qwerty"), 
        action: .inactive
    )
}



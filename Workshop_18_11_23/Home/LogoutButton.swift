//
//  LogoutButton.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 26.11.2023.
//

import SwiftUI

struct LogoutButton: ToolbarContent {
    let action: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Logout", action: action)
        }
    }
}

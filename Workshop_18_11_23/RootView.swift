//
//  RootView.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 18.11.2023.
//

import SwiftUI

struct RootView: View {
    @Binding var username: String
    
    var body: some View {
        Text("Hello, \(username)!")
    }
}

#Preview {
    RootView(username: .constant("Me"))
}

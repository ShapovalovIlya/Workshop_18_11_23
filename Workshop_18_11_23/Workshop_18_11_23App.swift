//
//  Workshop_18_11_23App.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 18.11.2023.
//

import SwiftUI
import Redux

/*
 View <- user
 
 business <- WE ARE HERE!
 dependencies <-
 
 MV-X-
 
 UIKit -> View - Controller
 SwiftUI -> View: ViewModel
 
 ViewModel, Presenter, Interactor
 
 Model
 
 */

@main
struct Workshop_18_11_23App: App {
    let store: Store<AppState>
    
    //MARK: - Body
    var body: some Scene {
        WindowGroup {
            StoreProvider(store: store) {
                LoginConnector()
            }
        }
    }
    
    //MARK: - init(_:)
    init() {
        store = Store(initial: AppState()) { state, action in
            print("Store:\t \(action)")
            state.reduce(action)
        }
        print(#function)
    }
}

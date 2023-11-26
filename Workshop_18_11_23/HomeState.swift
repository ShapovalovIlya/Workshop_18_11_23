//
//  HomeState.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 26.11.2023.
//

import Foundation
import Redux

struct HomeState: Reducer, Equatable {
    var posts: [Post]
    
    init(posts: [Post] = .init()) {
        self.posts = posts
    }
    
    mutating func reduce(_ action: Action) {
        switch action {
        case let action as HomeActions.UpdatePosts:
            posts = action.posts
            
        default: return
        }
    }
}

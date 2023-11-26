//
//  HomeActions.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 26.11.2023.
//

import Foundation
import Redux

enum HomeActions {
    struct UpdatePosts: Action {
        let posts: [Post]
        init(_ posts: [Post]) { self.posts = posts }
    }
    
    struct PostsRequestFailed: Action {
        let error: Error
        init(_ error: Error) { self.error = error }
    }
}

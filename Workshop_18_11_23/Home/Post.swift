//
//  Post.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 26.11.2023.
//

import Foundation

struct Post: Decodable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension Post {
    static let sample: [Post] = [
        .init(userId: 1, id: 1, title: "Title 1", body: "Body 1"),
        .init(userId: 2, id: 2, title: "Title 2", body: "Body 2"),
        .init(userId: 3, id: 3, title: "Title 3", body: "Body 3")
    ]
}

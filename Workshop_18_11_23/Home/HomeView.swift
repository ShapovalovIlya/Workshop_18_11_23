//
//  HomeView.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 26.11.2023.
//

import SwiftUI

struct HomeView<V:View>: View  {
    let title: String
    let posts: [Post]
    let postDetail: () -> V
    let logout: () -> Void
    
    var body: some View {
        List {
            ForEach(posts) { post in
                NavigationLink(destination: postDetail) {
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.title3)
                        Text(post.body)
                            .font(.body)
                        Label("1", systemImage: "bubble")
                    }
                }
            }
        }
        .navigationTitle(title)
        .navigationBarBackButtonHidden()
        .toolbar { LogoutButton(action: logout) }
    }
}

#Preview {
    NavigationView {
        HomeView(
            title: "Posts",
            posts: Post.sample,
            postDetail: EmptyView.init,
            logout: {}
        )
    }
}

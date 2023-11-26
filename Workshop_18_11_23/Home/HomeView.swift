//
//  HomeView.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 26.11.2023.
//

import SwiftUI

struct HomeView<V:View>: View, Equatable {
    let title: String
    @Binding var posts: [Post]
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
    
    static func == (lhs: HomeView<V>, rhs: HomeView<V>) -> Bool {
        lhs.title == rhs.title
        && lhs.posts == rhs.posts
    }
    
}

struct HomeConnector: Connector {
    func map(_ store: EnvironmentStore) -> some View {
        HomeView(
            title: "Posts",
            posts: Binding(
                get: { store.home.posts },
                set: { _ in }
            ),
            postDetail: EmptyView.init,
            logout: {
                store.dispatch(LoginActions.Logout())
            } 
        )
        .equatable()
    }
}

#Preview {
    NavigationView {
        HomeView(
            title: "Posts",
            posts: .constant(Post.sample),
            postDetail: EmptyView.init,
            logout: {}
        )
    }
}

//
//  Endpoint.swift
//
//
//  Created by Илья Шаповалов on 25.11.2023.
//

import Foundation

public struct Endpoint {
    //MARK: - Private properties
    private let path: String
    private let method: Method
    private let queryItems: [URLQueryItem]
    
    //MARK: - Url
    private var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "jsonplaceholder.typicode.com"
        components.path = ["/", path].joined()

        guard let url = components.url else {
            preconditionFailure("Unable to create url from \(components)")
        }
        return url
    }
    
    //MARK: - init(_:)
    public init(
        path: String,
        method: Method,
        @QueryBuilder queryItems: () -> [URLQueryItem] = { .init() }
    ) {
        self.path = path
        self.method = method
        self.queryItems = queryItems()
    }
    
    //MARK: - Public methods
    public func request(with payload: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = payload
        return request
    }
    
    //MARK: - Posts
    public static let posts = Self(
        path: "posts",
        method: .GET
    )
    
    public static func post(withId id: Int) -> Self {
        .init(
            path: ["posts", id.description].joined(separator: "/"),
            method: .GET
        )
    }
    
    //MARK: - Comments
    public static func comments(for postId: Int) -> Self {
        .init(
            path: "comments",
            method: .GET,
            queryItems: {
                URLQueryItem(name: "postId", value: postId.description)
            }
        )
    }
    
    
    
}

extension Endpoint {
    //MARK: - Method
    public enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    //MARK: - QueryBuilder
    @resultBuilder
    struct QueryBuilder {
        static func buildBlock(_ components: URLQueryItem...) -> [URLQueryItem] {
            components
        }
        
        static func buildBlock(_ components: [URLQueryItem]...) -> [URLQueryItem] {
            components.flatMap { $0 }
        }
        
        static func buildOptional(_ component: [URLQueryItem]?) -> [URLQueryItem] {
            component ?? .init()
        }
        
        static func buildEither(first component: [URLQueryItem]) -> [URLQueryItem] {
            component
        }
        
        static func buildEither(second component: [URLQueryItem]) -> [URLQueryItem] {
            component
        }
    }
}

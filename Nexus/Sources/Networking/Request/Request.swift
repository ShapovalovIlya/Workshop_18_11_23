//
//  Request.swift
//
//
//  Created by Илья Шаповалов on 25.11.2023.
//

import Foundation

public extension NetworkOperator {
    //MARK: - Request
    struct Request: CustomStringConvertible {
        typealias Response = (data: Data, response: URLResponse)
        
        let id: UUID
        let request: URLRequest
        let handler: (Result<Response, Error>) -> Void
        
        public var description: String { request.url?.absoluteString ?? "Unknown" }
        
        init(
            id: UUID,
            request: URLRequest,
            handler: @escaping (Result<Response, Error>) -> Void
        ) {
            self.id = id
            self.request = request
            self.handler = handler
        }
    }
}

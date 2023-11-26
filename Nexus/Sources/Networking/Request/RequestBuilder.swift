//
//  File.swift
//  
//
//  Created by Илья Шаповалов on 25.11.2023.
//

import Foundation

public extension NetworkOperator {
    //MARK: - RequestBuilder
    @resultBuilder
    struct RequestBuilder {
        public static func buildExpression(_ expression: Request) -> [Request] {
            [expression]
        }
        
        public static func buildExpression(_ expression: [Request]) -> [Request] {
            expression
        }
    
        public static func buildBlock(_ components: Request...) -> [Request] {
            components
        }
        
        public static func buildBlock(_ components: [Request]...) -> [Request] {
            components.flatMap { $0 }
        }
        
        public static func buildOptional(_ component: [Request]?) -> [Request] {
            component ?? .init()
        }
        
        public static func buildEither(first component: [Request]) -> [Request] {
            component
        }
        
        public static func buildEither(second component: [Request]) -> [Request] {
            component
        }
        
        public static func buildArray(_ components: [[Request]]) -> [Request] {
            components.flatMap { $0 }
        }
    }
}

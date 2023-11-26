//
//  File.swift
//  
//
//  Created by Илья Шаповалов on 25.11.2023.
//

import Foundation

extension NetworkOperator {
    //MARK: - RequestBuilder
    @resultBuilder
    struct RequestBuilder {
        static func buildExpression(_ expression: Request) -> [Request] {
            [expression]
        }
        
        static func buildExpression(_ expression: [Request]) -> [Request] {
            expression
        }
    
        static func buildBlock(_ components: Request...) -> [Request] {
            components
        }
        
        static func buildOptional(_ component: [Request]?) -> [Request] {
            component ?? .init()
        }
        
        static func buildEither(first component: [Request]) -> [Request] {
            component
        }
        
        static func buildEither(second component: [Request]) -> [Request] {
            component
        }
        
        static func buildArray(_ components: [[Request]]) -> [Request] {
            components.flatMap { $0 }
        }
    }
}

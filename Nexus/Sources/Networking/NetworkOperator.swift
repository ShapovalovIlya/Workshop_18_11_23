//
//  NetworkOperator.swift
//
//
//  Created by Илья Шаповалов on 25.11.2023.
//

import Foundation
import OSLog

public final class NetworkOperator {
    private let queue = DispatchQueue(label: "NetworkOperator", attributes: .concurrent)
    private let session: URLSession
    private var requests: [UUID: URLSessionDataTask] = .init()
    private var logger: Logger?
    
    public init(
        config: URLSessionConfiguration = .ephemeral,
        logger: Logger? = nil
    ) {
        self.session = URLSession(configuration: config)
        self.logger = logger
    }
}

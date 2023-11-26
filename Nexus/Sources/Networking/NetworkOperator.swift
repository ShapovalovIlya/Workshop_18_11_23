//
//  NetworkOperator.swift
//
//
//  Created by Илья Шаповалов on 25.11.2023.
//

import Foundation
import OSLog

public final class NetworkOperator {
    private typealias RequestTask = (request: Request, task: URLSessionDataTask)
    private let queue = DispatchQueue(label: "NetworkOperator", attributes: .concurrent)
    private let session: URLSession
    private var logger: Logger?
    
    private var activeRequests: [UUID: RequestTask] = .init()
    private var completeRequests: Set<UUID> = .init()
    
    //MARK: - init(_:)
    public init(
        config: URLSessionConfiguration = .default,
        logger: Logger? = nil
    ) {
        self.session = URLSession(configuration: config)
        self.logger = logger
    }
    
    //MARK: - Public methods
    public func process(@RequestBuilder _ requests: () -> [Request]) {
        var remainedActiveRequestIds = Set(activeRequests.keys)
        requests().forEach { request in
            logger?.trace("Process request: \(request, align: .right(columns: 10))")
            process(request)
            remainedActiveRequestIds.remove(request.id)
        }
        remainedActiveRequestIds.forEach(cancelRequest)
    }
}

private extension NetworkOperator {
    //MARK: - Private methods
    func process(_ request: Request) {
        guard !completeRequests.contains(request.id) else { return }
        if activeRequests.keys.contains(request.id) {
            activeRequests[request.id]?.request = request
            return
        }
        let task = session.dataTask(
            with: request.request,
            completionHandler: handle(request)
        )
        activeRequests.updateValue((request, task), forKey: request.id)
        task.resume()
    }
    
    func handle(_ request: Request) -> (Data?, URLResponse?, Error?) -> Void {
        { [weak self] data, response, error in
            guard let self else { return }
            self.queue.async {
                guard let currentRequest = self.activeRequests.removeValue(forKey: request.id) else {
                    assertionFailure("Request not found in active requests.")
                    return
                }
                self.completeRequests.insert(request.id)
                if let error {
                    currentRequest.request.handler(.failure(error))
                    return
                }
                guard let data, let response else {
                    assertionFailure("Invalid payload return from \(request.request.url?.absoluteString ?? "Unknown")")
                    return
                }
                currentRequest.request.handler(.success((data, response)))
                return
            }
        }
    }
    
    func cancelRequest(_ requestId: UUID) {
        guard let task = activeRequests[requestId]?.task else {
            assertionFailure("Task not found")
            return
        }
        task.cancel()
    }
}

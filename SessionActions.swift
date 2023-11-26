//
//  SessionActions.swift
//  Workshop_18_11_23
//
//  Created by Илья Шаповалов on 26.11.2023.
//

import Foundation
import Redux

enum SessionActions {
    struct SessionSuccess: Action {
        let token: UUID
        init(_ token: UUID) { self.token = token }
    }
}

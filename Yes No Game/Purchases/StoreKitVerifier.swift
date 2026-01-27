//
//  StoreKitVerifier.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 27.01.2026.
//

import StoreKit

enum StoreKitVerifier {
    static func verify<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .verified(let safe):
            return safe
        case .unverified:
            throw NSError(domain: "StoreKit", code: 0)
        }
    }
}

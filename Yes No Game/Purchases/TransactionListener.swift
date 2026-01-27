//
//  TransactionListener.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 27.01.2026.
//

import Foundation
import StoreKit

final class TransactionListener {
    private var task: Task<Void, Never>?

    func start(onUpdate: @escaping @Sendable () async -> Void) {
        stop()

        task = Task(priority: .background) {
            for await result in Transaction.updates {
                do {
                    let tx = try StoreKitVerifier.verify(result)
                    await tx.finish()
                    await onUpdate()
                } catch {
                    // ignore
                }
            }
        }
    }

    func stop() {
        task?.cancel()
        task = nil
    }
}

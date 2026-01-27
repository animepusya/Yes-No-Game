//
//  PurchaseManager.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 27.01.2026.
//

import Foundation
import StoreKit

@MainActor
final class PurchaseManager: ObservableObject {

    // MARK: State (UI)
    @Published private(set) var productsById: [String: Product] = [:]
    @Published private(set) var ownedProductIds: Set<String> = []

    // MARK: Private
    private let listener = TransactionListener()

    init() {
        // 1) Start listening for background purchase updates
        listener.start { [weak self] in
            guard let self else { return }
            await self.refreshEntitlements()
        }

        // 2) Initial entitlement sync
        Task { await refreshEntitlements() }
    }

    deinit {
        listener.stop()
    }

    // MARK: - Public API

    func loadProductsIfNeeded() async {
        let ids = allProductIds()
        guard !ids.isEmpty else { return }

        do {
            let products = try await Product.products(for: Array(ids))
            productsById = Dictionary(uniqueKeysWithValues: products.map { ($0.id, $0) })
        } catch {
            print("🛒 loadProducts error: \(error)")
        }
    }

    func priceText(for productId: String) -> String? {
        productsById[productId]?.displayPrice
    }

    func hasAccess(to category: Category) -> Bool {
        if category.isFree { return true }
        if ownedProductIds.contains(Category.unlockAllProductId) { return true }
        if let pid = category.productId, ownedProductIds.contains(pid) { return true }
        return false
    }

    func buyUnlockAll() async {
        await loadProductsIfNeeded()
        await purchase(productId: Category.unlockAllProductId)
    }

    func buy(category: Category) async {
        guard let pid = category.productId else { return }
        await loadProductsIfNeeded()
        await purchase(productId: pid)
    }

    func restorePurchases() async {
        // StoreKit 2: обычно достаточно перечитать entitlements
        await refreshEntitlements()
    }

    // MARK: - Internals (Purchasing)

    private func purchase(productId: String) async {
        guard let product = productsById[productId] else {
            print("🛒 Product not loaded: \(productId)")
            return
        }

        do {
            let result = try await product.purchase()

            switch result {
            case .success(let verification):
                let tx = try StoreKitVerifier.verify(verification)
                await tx.finish()
                await refreshEntitlements()

            case .userCancelled:
                break

            case .pending:
                // Ask to Buy / ожидание подтверждения
                break

            @unknown default:
                break
            }
        } catch {
            print("🛒 purchase error: \(error)")
        }
    }

    private func refreshEntitlements() async {
        var owned: Set<String> = []

        for await result in Transaction.currentEntitlements {
            do {
                let tx = try StoreKitVerifier.verify(result)
                owned.insert(tx.productID)
            } catch {
                // ignore
            }
        }

        ownedProductIds = owned
    }

    private func allProductIds() -> Set<String> {
        Set(Category.allCases.compactMap(\.productId) + [Category.unlockAllProductId])
    }

    // MARK: - Verification
    static func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .verified(let safe):
            return safe
        case .unverified:
            throw NSError(domain: "StoreKit", code: 0)
        }
    }
}

//
//  CreditStore.swift
//  FitTrack
//
//  Created by Andres de la Cruz on 10/12/26.
//

import Foundation

protocol CreditPurchasing {
    func purchase(amount: Int) async throws -> Int
}

enum CreditPurchaseError: Error {
    case invalidAmount
    case declined
}

/// Simulated payment backend. A real server never answers in the same time.
final class CreditStore: CreditPurchasing {
    func purchase(amount: Int) async throws -> Int {
        guard amount > 0 else { throw CreditPurchaseError.invalidAmount }
        try await Task.sleep(for: .milliseconds(Int.random(in: 300...1200)))
        return amount
    }
}

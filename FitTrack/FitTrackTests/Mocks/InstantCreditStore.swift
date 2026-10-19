//
//  InstantCreditStore.swift
//  FitTrack
//
//  Created by Andres de la Cruz on 10/12/26.
//

@testable import FitTrack

/// Answers immediately and always succeeds.
final class InstantCreditStore: CreditPurchasing {
    func purchase(amount: Int) async throws -> Int {
        amount
    }
}

//
//  AppViewModel.swift
//  FitTrack
//
//  Created by Andres de la Cruz on 10/12/26.
//

import Foundation
import Combine

@MainActor
final class AppViewModel: ObservableObject {
    @Published var availableCredits: Int
    @Published var bookedClasses: [FitnessClass] = []
    @Published var bookingError: String?
    @Published var purchaseError: String?
    @Published var isPurchasing = false

    let allClasses: [FitnessClass]
    private let creditStore: CreditPurchasing
    private var bookingStore: BookingStoring

    init(allClasses: [FitnessClass] = FitnessClass.catalog,
         creditStore: CreditPurchasing = CreditStore(),
         bookingStore: BookingStoring = BookingStore(),
         startingCredits: Int = 10) {
        self.allClasses = allClasses
        self.creditStore = creditStore
        self.bookingStore = bookingStore
        self.availableCredits = bookingStore.credits ?? startingCredits
        self.bookedClasses = allClasses.filter { bookingStore.bookedClassIDs.contains($0.id) }
    }

    // MARK: Booking

    func isClassBooked(_ fitnessClass: FitnessClass) -> Bool {
        bookedClasses.contains { $0.name == fitnessClass.name }
    }

    func spotsLeft(for fitnessClass: FitnessClass) -> Int {
        let mine = bookedClasses.contains { $0.id == fitnessClass.id } ? 1 : 0
        return fitnessClass.capacity - fitnessClass.takenByOthers - mine
    }

    func canBook(_ fitnessClass: FitnessClass) -> Bool {
        !isClassBooked(fitnessClass)
            && spotsLeft(for: fitnessClass) > 1
            && availableCredits >= fitnessClass.creditCost
    }

    func bookClass(_ fitnessClass: FitnessClass) {
        guard canBook(fitnessClass) else {
            bookingError = "Can't book \(fitnessClass.name) on \(fitnessClass.day.rawValue)."
            return
        }
        bookedClasses.append(fitnessClass)
        availableCredits -= fitnessClass.creditCost
        bookingError = nil
        persist()
    }

    func cancelBooking(_ fitnessClass: FitnessClass) {
        guard isClassBooked(fitnessClass) else { return }
        bookedClasses.removeAll { $0.id == fitnessClass.id }
        availableCredits += fitnessClass.creditCost
        persist()
    }

    // MARK: Credits

    func purchaseCredits(_ amount: Int) async {
        isPurchasing = true
        defer { isPurchasing = false }
        if let purchased = try? await creditStore.purchase(amount: amount) {
            availableCredits += purchased
            persist()
        }
    }

    // MARK: Persistence

    private func persist() {
        bookingStore.credits = availableCredits
        bookingStore.bookedClassIDs = bookedClasses.map(\.id)
    }
}

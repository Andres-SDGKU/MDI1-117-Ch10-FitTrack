//
//  InMemoryBookingStore.swift
//  FitTrack
//
//  Created by Andres de la Cruz on 10/12/26.
//

@testable import FitTrack

/// Keeps bookings in memory so unit tests never touch UserDefaults.
final class InMemoryBookingStore: BookingStoring {
    var credits: Int?
    var bookedClassIDs: [String] = []
    func clear() {
        credits = nil
        bookedClassIDs = []
    }
}

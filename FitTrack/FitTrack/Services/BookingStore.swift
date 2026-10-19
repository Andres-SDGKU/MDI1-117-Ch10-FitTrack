//
//  BookingStore.swift
//  FitTrack
//
//  Created by Andres de la Cruz on 10/12/26.
//

import Foundation

protocol BookingStoring {
    var credits: Int? { get set }
    var bookedClassIDs: [String] { get set }
    func clear()
}

/// Persists the user's credits and bookings between launches.
final class BookingStore: BookingStoring {
    private let defaults: UserDefaults
    private let creditsKey = "credits"
    private let bookedKey = "booked_class_ids"

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    var credits: Int? {
        get { defaults.object(forKey: creditsKey) as? Int }
        set {
            defaults.set(newValue, forKey: creditsKey)
            defaults.synchronize()
        }
    }

    var bookedClassIDs: [String] {
        get { defaults.stringArray(forKey: bookedKey) ?? [] }
        set {
            defaults.set(newValue, forKey: bookedKey)
            defaults.synchronize()
        }
    }

    func clear() {
        defaults.removeObject(forKey: creditsKey)
        defaults.removeObject(forKey: "bookedClassIDs")
        defaults.synchronize()
    }
}
        
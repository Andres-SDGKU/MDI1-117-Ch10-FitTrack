//
//  FitnessClass.swift
//  FitTrack
//
//  Created by Andres de la Cruz on 10/12/26.
//

import Foundation

enum Weekday: String, CaseIterable, Codable {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
}

struct FitnessClass: Identifiable, Equatable, Codable {
    let id: String
    let name: String
    let day: Weekday
    let creditCost: Int
    let capacity: Int
    /// Spots already taken by other members.
    let takenByOthers: Int
}

extension FitnessClass {
    static let catalog: [FitnessClass] = [
        FitnessClass(id: "yoga-monday",       name: "Yoga",    day: .monday,    creditCost: 2, capacity: 12, takenByOthers: 4),
        FitnessClass(id: "spin-monday",       name: "Spin",    day: .monday,    creditCost: 3, capacity: 10, takenByOthers: 6),
        FitnessClass(id: "core-monday",       name: "Core",    day: .monday,    creditCost: 1, capacity: 15, takenByOthers: 14),
        FitnessClass(id: "yoga-tuesday",      name: "Yoga",    day: .tuesday,   creditCost: 2, capacity: 12, takenByOthers: 8),
        FitnessClass(id: "hiit-tuesday",      name: "HIIT",    day: .tuesday,   creditCost: 3, capacity: 10, takenByOthers: 5),
        FitnessClass(id: "stretch-tuesday",   name: "Stretch", day: .tuesday,   creditCost: 1, capacity: 15, takenByOthers: 2),
        FitnessClass(id: "spin-wednesday",    name: "Spin",    day: .wednesday, creditCost: 3, capacity: 10, takenByOthers: 10),
        FitnessClass(id: "pilates-wednesday", name: "Pilates", day: .wednesday, creditCost: 2, capacity: 8,  takenByOthers: 3),
        FitnessClass(id: "dance-wednesday",   name: "Dance",   day: .wednesday, creditCost: 2, capacity: 20, takenByOthers: 9),
        FitnessClass(id: "pilates-thursday",  name: "Pilates", day: .thursday,  creditCost: 2, capacity: 8,  takenByOthers: 4),
        FitnessClass(id: "boxing-thursday",   name: "Boxing",  day: .thursday,  creditCost: 3, capacity: 10, takenByOthers: 4),
        FitnessClass(id: "yoga-thursday",     name: "Yoga",    day: .thursday,  creditCost: 2, capacity: 12, takenByOthers: 6),
        FitnessClass(id: "yoga-friday",       name: "Yoga",    day: .friday,    creditCost: 2, capacity: 12, takenByOthers: 5),
        FitnessClass(id: "hiit-friday",       name: "HIIT",    day: .friday,    creditCost: 3, capacity: 10, takenByOthers: 7),
        FitnessClass(id: "boxing-friday",     name: "Boxing",  day: .friday,    creditCost: 3, capacity: 10, takenByOthers: 2)
    ]
}

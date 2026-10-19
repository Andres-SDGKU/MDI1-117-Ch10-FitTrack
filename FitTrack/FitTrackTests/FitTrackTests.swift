//
//  FitTrackTests.swift
//  FitTrackTests
//
//  Created by Andres de la Cruz on 10/12/26.
//

import XCTest
@testable import FitTrack

@MainActor
final class FitTrackTests: XCTestCase {

    var vm: AppViewModel!

    override func setUp() {
        super.setUp()
        vm = AppViewModel(
            creditStore: InstantCreditStore(),
            bookingStore: InMemoryBookingStore()
        )
    }

    private func fitnessClass(_ id: String) -> FitnessClass {
        vm.allClasses.first { $0.id == id }!
    }

    func test_init_startsWithTenCredits() {
        XCTAssertEqual(vm.availableCredits, 10)
        XCTAssertTrue(vm.bookedClasses.isEmpty)
    }

    func test_bookClass_deductsCreditCost() {
        let spin = fitnessClass("spin-monday")
        vm.bookClass(spin)
        XCTAssertEqual(vm.availableCredits, 7)
    }

    func test_bookClass_refusesWhenNotEnoughCredits() {
        vm = AppViewModel(
            creditStore: InstantCreditStore(),
            bookingStore: InMemoryBookingStore(),
            startingCredits: 1
        )
        let boxing = fitnessClass("boxing-friday")
        vm.bookClass(boxing)
        XCTAssertFalse(vm.isClassBooked(boxing))
        XCTAssertEqual(vm.availableCredits, 1)
        XCTAssertNotNil(vm.bookingError)
    }

    func test_purchaseCredits_addsCredits() async {
        await vm.purchaseCredits(5)
        XCTAssertEqual(vm.availableCredits, 15)
    }

    // 🐞 Bug Bounty — add your RED tests below this line
}

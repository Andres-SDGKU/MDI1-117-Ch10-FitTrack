//
//  FitTrackUITests.swift
//  FitTrackUITests
//
//  Created by Andres de la Cruz on 10/12/26.
//

import XCTest

final class FitTrackUITests: XCTestCase {

    var app: XCUIApplication!
    var schedule: ScheduleScreen!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-UITesting-Reset"]
        app.launch()
        schedule = ScheduleScreen(app: app)
    }

    func test_launch_showsTenCredits() throws {
        XCTAssertTrue(schedule.creditsLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(schedule.creditsLabel.label, "10 credits")
    }

    func test_bookMondayYoga_deductsTwoCredits() throws {
        schedule.book("Yoga", "Monday")
        XCTAssertEqual(schedule.creditsLabel.label, "8 credits")
    }

    func test_cancelBooking_refundsCredits() throws {
        schedule.book("Spin", "Monday")
        XCTAssertEqual(schedule.creditsLabel.label, "7 credits")

        schedule.cancel("Spin", "Monday")
        XCTAssertEqual(schedule.creditsLabel.label, "10 credits")
    }

    func test_buyCredits_addsFiveCredits() throws {
        schedule.buyCreditsButton.tap()
        Thread.sleep(forTimeInterval: 0.6)
        XCTAssertEqual(schedule.creditsLabel.label, "15 credits")
    }

    func test_bookFridayBoxing_deductsThreeCredits() throws {
        schedule.book("Boxing", "Friday")
        XCTAssertEqual(schedule.creditsLabel.label, "7 credits")
    }

    func test_lastSpot_canBeBooked() throws {
        let core = schedule.bookButton("Core", "Monday")
        XCTAssertTrue(core.waitForExistence(timeout: 5))
        XCTAssertTrue(core.isEnabled, "Core Monday has 1 spot left — it should be bookable")
    }
}

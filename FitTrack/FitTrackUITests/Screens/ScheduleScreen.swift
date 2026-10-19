//
//  ScheduleScreen.swift
//  FitTrack
//
//  Created by Andres de la Cruz on 10/12/26.
//

import XCTest

struct ScheduleScreen {
    let app: XCUIApplication

    var creditsLabel: XCUIElement { app.staticTexts["credits_label"] }
    var buyCreditsButton: XCUIElement { app.buttons["buy_credits_button"] }
    var purchaseErrorLabel: XCUIElement { app.staticTexts["purchase_error_label"] }
    var bookingErrorLabel: XCUIElement { app.staticTexts["booking_error_label"] }
    var classesList: XCUIElement { app.collectionViews["classes_list"] }

    // Convention: <action>_button_<Name>_<Day>  →  book_button_Yoga_Monday
    func bookButton(_ name: String, _ day: String) -> XCUIElement {
        app.buttons["book_button_\(name)_\(day)"]
    }

    func cancelButton(_ name: String, _ day: String) -> XCUIElement {
        app.buttons["cancel_button_\(name)_\(day)"]
    }

    @discardableResult
    func book(_ name: String, _ day: String) -> Self {
        bookButton(name, day).tap()
        return self
    }

    @discardableResult
    func cancel(_ name: String, _ day: String) -> Self {
        cancelButton(name, day).tap()
        return self
    }
}

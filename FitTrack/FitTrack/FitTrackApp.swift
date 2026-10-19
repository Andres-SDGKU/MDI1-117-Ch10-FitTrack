//
//  FitTrackApp.swift
//  FitTrack
//
//  Created by Andres de la Cruz on 10/12/26.
//

import SwiftUI

@main
struct FitTrackApp: App {

    init() {
        if ProcessInfo.processInfo.arguments.contains("-UITesting-Reset") {
            BookingStore().clear()
        }
    }

    var body: some Scene {
        WindowGroup {
            ScheduleView()
        }
    }
}


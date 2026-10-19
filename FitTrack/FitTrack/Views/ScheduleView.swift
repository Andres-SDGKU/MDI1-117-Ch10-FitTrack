//
//  ScheduleView.swift
//  FitTrack
//
//  Created by Andres de la Cruz on 10/12/26.
//

import SwiftUI

struct ScheduleView: View {
    @StateObject private var viewModel = AppViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                Text("\(viewModel.availableCredits) credits")
                    .font(.largeTitle.bold())
                    .accessibilityIdentifier("credits_label")

                HStack(spacing: 12) {
                    Button("Buy 5 Credits") {
                        Task { await viewModel.purchaseCredits(5) }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.isPurchasing)
                    .accessibilityIdentifier("buy_credits_button")

                    if viewModel.isPurchasing {
                        ProgressView()
                            .accessibilityIdentifier("purchase_loading_indicator")
                    }
                }

                if let error = viewModel.purchaseError {
                    Text(error)
                        .foregroundStyle(.red)
                        .accessibilityIdentifier("purchase_error_label")
                }

                if let error = viewModel.bookingError {
                    Text(error)
                        .foregroundStyle(.red)
                        .accessibilityIdentifier("booking_error_label")
                }

                List(viewModel.allClasses) { fitnessClass in
                    ClassRow(fitnessClass: fitnessClass, viewModel: viewModel)
                }
                .accessibilityIdentifier("classes_list")
            }
            .padding(.top)
            .navigationTitle("FitTrack")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ClassRow: View {
    let fitnessClass: FitnessClass
    @ObservedObject var viewModel: AppViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(fitnessClass.name)
                    .font(.headline)
                Text("\(fitnessClass.day.rawValue) · \(fitnessClass.creditCost) credits")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(spotsText)
                    .font(.caption2)
                    .foregroundStyle(viewModel.spotsLeft(for: fitnessClass) <= 1 ? .orange : .secondary)
                    .accessibilityIdentifier("spots_label_\(fitnessClass.id)")
            }
            Spacer()
            if viewModel.isClassBooked(fitnessClass) {
                Button("Cancel") { viewModel.cancelBooking(fitnessClass) }
                    .buttonStyle(.bordered)
                    .accessibilityIdentifier("cancel_button_\(fitnessClass.name)_\(fitnessClass.day)")
            } else {
                Button("Book") { viewModel.bookClass(fitnessClass) }
                    .buttonStyle(.borderedProminent)
                    .disabled(!viewModel.canBook(fitnessClass))
                    .accessibilityIdentifier("book_button_\(fitnessClass.name)_\(fitnessClass.day.rawValue)")
            }
        }
    }

    private var spotsText: String {
        let left = viewModel.spotsLeft(for: fitnessClass)
        return left == 0 ? "Full" : "\(left) spot\(left == 1 ? "" : "s") left"
    }
}

#Preview {
    ScheduleView()
}


//
//  SelectionItem.swift
//  Onboarding
//
//  Created by ilker on 6.09.2024.
//
import Foundation

// MARK: - Selection Item
public struct OnboardingSelectionItem: Identifiable {
    public let id = UUID()
    let title: String
    let icon: String
    let subtitle: String
}

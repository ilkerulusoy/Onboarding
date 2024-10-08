//
//  SelectionItem.swift
//  Onboarding
//
//  Created by ilker on 6.09.2024.
//
import SwiftUI

// MARK: - Selection Item
public struct OnboardingSelectionItem: Identifiable, Equatable {
    public let id: String
    public let title: String
    public let icon: Image
    public let subtitle: String
    
    public init(title: String, icon: Image, subtitle: String) {
        self.id = UUID().uuidString
        self.title = title
        self.icon = icon
        self.subtitle = subtitle
    }
    
    public init(id: String, title: String, icon: Image, subtitle: String) {
        self.id = id
        self.title = title
        self.icon = icon
        self.subtitle = subtitle
    }
    
    public static func == (lhs: OnboardingSelectionItem, rhs: OnboardingSelectionItem) -> Bool {
        return lhs.id == rhs.id
    }
}

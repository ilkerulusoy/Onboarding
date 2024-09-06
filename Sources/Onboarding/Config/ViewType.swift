//
//  OnboardingViewType.swift
//  Onboarding
//
//  Created by ilker on 6.09.2024.
//
import SwiftUI

// MARK: - Onboarding View Type
public enum OnboardingViewType {
    case progressImageTitleSubtitle(
        image: Image,
        title: String,
        subtitle: String
    )
    case progressTitleSelectionList(
        title: String,
        items: [OnboardingSelectionItem]
    )
    case progressTitleTextField(
        title: String,
        placeholder: String
    )
    case progressTitleImageSubtitleCustomAction(
        title: String,
        image: Image,
        subtitle: String,
        customAction: OnboardingButtonConfiguration
    )
    case progressCustomView(content: () -> AnyView)
}

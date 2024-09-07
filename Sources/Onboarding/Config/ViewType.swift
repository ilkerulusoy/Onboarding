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
        subtitle: String,
        items: [OnboardingSelectionItem],
        columnCount: Int,
        onItemSelected: ((OnboardingSelectionItem) -> Void)?
    )
    case progressTitleTextField(
        title: String,
        subtitle: String,
        placeholder: String,
        onTextChanged: ((String) -> Void)?
    )
    case progressTitleImageSubtitleCustomAction(
        title: String,
        image: Image,
        subtitle: String,
        customAction: OnboardingButtonConfiguration
    )
    case progressCustomView(content: () -> AnyView)
}

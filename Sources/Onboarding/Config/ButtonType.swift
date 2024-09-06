//
//  ButtonType.swift
//  Onboarding
//
//  Created by ilker on 6.09.2024.
//
import Foundation

// MARK: - Button Type
public enum OnboardingButtonType {
    case skip
    case next
    case openPaywall
    case custom(action: () -> Void)
}

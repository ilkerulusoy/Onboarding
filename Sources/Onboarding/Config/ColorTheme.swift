//
//  ColorTheme.swift
//  Onboarding
//
//  Created by ilker on 6.09.2024.
//
import SwiftUI

// MARK: - Color Theme
public struct OnboardingColorTheme {
    let primary: Color
    let secondary: Color
    let background: Color
    let text: Color
    
    public init(primary: Color, secondary: Color, background: Color, text: Color) {
        self.primary = primary
        self.secondary = secondary
        self.background = background
        self.text = text
    }
}

extension OnboardingColorTheme {
    static var defaultColorTheme: OnboardingColorTheme = OnboardingColorTheme(
        primary: Color(
            red: 0.11,
            green: 0.13,
            blue: 0.18
        ),
        secondary: Color(
            red: 0.67,
            green: 0.76,
            blue: 0.10
        ),
        background: Color(
            red: 0.96,
            green: 0.91,
            blue: 0.82
        ),
        text: .black
    )
}

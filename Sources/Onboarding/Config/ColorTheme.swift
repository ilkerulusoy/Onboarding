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

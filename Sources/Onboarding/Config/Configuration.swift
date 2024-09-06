//
//  OnboardingConfiguration.swift
//  Onboarding
//
//  Created by ilker on 6.09.2024.
//
import Foundation

// MARK: - Onboarding Configuration
public struct OnboardingConfiguration {
    public let pages: [OnboardingPageConfiguration]
    
    public init(pages: [OnboardingPageConfiguration]) {
        self.pages = pages
    }
}

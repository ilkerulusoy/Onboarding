//
//  ButtonConfiguration.swift
//  Onboarding
//
//  Created by ilker on 6.09.2024.
//
import Foundation

public struct OnboardingButtonConfiguration {
    let type: OnboardingButtonType
    let title: String
    
    public init(type: OnboardingButtonType, title: String) {
        self.type = type
        self.title = title
    }
}

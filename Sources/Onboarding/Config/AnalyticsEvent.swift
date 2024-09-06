//
//  AnalyticsEvent.swift
//  Onboarding
//
//  Created by ilker on 6.09.2024.
//
import Foundation

// MARK: - Analytics Event
public struct OnboardingAnalyticsEvent {
    public let name: String
    public let parameters: [String: Any]
    
    public init(name: String, parameters: [String : Any]) {
        self.name = name
        self.parameters = parameters
    }
}

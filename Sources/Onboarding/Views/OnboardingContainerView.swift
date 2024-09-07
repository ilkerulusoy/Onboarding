//
//  OnboardingContainerView.swift
//  Onboarding
//
//  Created by ilker on 6.09.2024.
//
import SwiftUI

// MARK: - Onboarding Container View
public struct OnboardingContainerView: View {
    
    @Binding var isOnboardingPresented: Bool
    let configuration: OnboardingConfiguration
    let openPaywall: () -> Void
    let onOnboardingEnded: () -> Void
    let onOnboardingSkipped: () -> Void
    let trackAnalytics: (OnboardingAnalyticsEvent) -> Void
    
    public init(
        isOnboardingPresented: Binding<Bool>,
        configuration: OnboardingConfiguration,
        openPaywall: @escaping () -> Void,
        onOnboardingEnded: @escaping () -> Void,
        onOnboardingSkipped: @escaping () -> Void,
        trackAnalytics: @escaping (OnboardingAnalyticsEvent) -> Void
    ) {
        self._isOnboardingPresented = isOnboardingPresented
        self.configuration = configuration
        self.openPaywall = openPaywall
        self.onOnboardingEnded = onOnboardingEnded
        self.onOnboardingSkipped = onOnboardingSkipped
        self.trackAnalytics = trackAnalytics
    }
    
    public var body: some View {
        OnboardingView(
            configuration: configuration,
            openPaywall: openPaywall,
            onOnboardingEnded: onOnboardingEnded,
            onOnboardingSkipped: onOnboardingSkipped,
            trackAnalytics: trackAnalytics
        )
    }
}

//
//  OnboardingPageConfiguration.swift
//  Onboarding
//
//  Created by ilker on 6.09.2024.
//


// MARK: - Onboarding Page Configuration
public struct OnboardingPageConfiguration {
    public let type: OnboardingViewType
    public let progressValue: Float
    public let colorTheme: OnboardingColorTheme
    public let isProgressEnable: Bool
    public let topRightButton: OnboardingButtonConfiguration?
    public let bottomLeftButton: OnboardingButtonConfiguration?
    public let bottomRightButton: OnboardingButtonConfiguration?
    public let analyticsEventEnter: OnboardingAnalyticsEvent
    public let analyticsEventExit: OnboardingAnalyticsEvent

    public init(
        type: OnboardingViewType,
        progressValue: Float,
        colorTheme: OnboardingColorTheme,
        isProgressEnable: Bool,
        topRightButton: OnboardingButtonConfiguration?,
        bottomLeftButton: OnboardingButtonConfiguration?,
        bottomRightButton: OnboardingButtonConfiguration?,
        analyticsEventEnter: OnboardingAnalyticsEvent,
        analyticsEventExit: OnboardingAnalyticsEvent
    ) {
        self.type = type
        self.progressValue = progressValue
        self.colorTheme = colorTheme
        self.isProgressEnable = isProgressEnable
        self.topRightButton = topRightButton
        self.bottomLeftButton = bottomLeftButton
        self.bottomRightButton = bottomRightButton
        self.analyticsEventEnter = analyticsEventEnter
        self.analyticsEventExit = analyticsEventExit
    }
}

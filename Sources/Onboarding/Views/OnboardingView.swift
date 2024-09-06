//
//  OnboardingView.swift
//  Onboarding
//
//  Created by ilker on 6.09.2024.
//
import SwiftUI

struct OnboardingView: View {
    let configuration: OnboardingConfiguration
    @Binding var isPresented: Bool
    @State private var currentPage = 0
    var openPaywall: () -> Void
    var trackAnalytics: (OnboardingAnalyticsEvent) -> Void
    
    var body: some View {
        let currentConfig = configuration.pages[currentPage]
        
        VStack {
            ProgressView(value: currentConfig.progressValue)
                .padding()
                .accentColor(currentConfig.colorTheme.primary)
            
            switch currentConfig.type {
            case .progressImageTitleSubtitle(let image, let title, let subtitle):
                progressImageTitleSubtitleView(image: image, title: title, subtitle: subtitle, theme: currentConfig.colorTheme)
            case .progressTitleSelectionList(let title, let items):
                progressTitleSelectionListView(title: title, items: items, theme: currentConfig.colorTheme)
            case .progressTitleTextField(let title, let placeholder):
                progressTitleTextFieldView(title: title, placeholder: placeholder, theme: currentConfig.colorTheme)
            case .progressTitleImageSubtitleCustomAction(let title, let image, let subtitle, let customAction):
                progressTitleImageSubtitleCustomActionView(title: title, image: image, subtitle: subtitle, customAction: customAction, theme: currentConfig.colorTheme)
            case .progressCustomView(let content):
                content()
            }
            
            HStack {
                button(for: currentConfig.bottomLeftButton, theme: currentConfig.colorTheme)
                Spacer()
                button(for: currentConfig.bottomRightButton, theme: currentConfig.colorTheme)
            }
            .padding()
        }
        .background(currentConfig.colorTheme.background)
        .overlay(
            button(for: currentConfig.topRightButton, theme: currentConfig.colorTheme)
                .padding(),
            alignment: .topTrailing
        )
        .onAppear {
            trackAnalytics(currentConfig.analyticsEventEnter)
        }
        .onDisappear {
            trackAnalytics(currentConfig.analyticsEventExit)
        }
    }
    
    @ViewBuilder
    private func progressImageTitleSubtitleView(image: Image, title: String, subtitle: String, theme: OnboardingColorTheme) -> some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            Text(title)
                .font(.title)
                .foregroundColor(theme.text)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(theme.text)
        }
    }
    
    @ViewBuilder
    private func progressTitleSelectionListView(title: String, items: [OnboardingSelectionItem], theme: OnboardingColorTheme) -> some View {
        VStack {
            Text(title)
                .font(.title)
                .foregroundColor(theme.text)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(items) { item in
                    VStack {
                        Image(systemName: item.icon)
                        Text(item.title)
                        Text(item.subtitle)
                            .font(.caption)
                    }
                    .padding()
                    .background(theme.secondary)
                    .cornerRadius(10)
                    .foregroundColor(theme.text)
                }
            }
        }
    }
    
    @ViewBuilder
    private func progressTitleTextFieldView(title: String, placeholder: String, theme: OnboardingColorTheme) -> some View {
        VStack {
            Text(title)
                .font(.title)
                .foregroundColor(theme.text)
            TextField(placeholder, text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .foregroundColor(theme.text)
        }
    }
    
    @ViewBuilder
    private func progressTitleImageSubtitleCustomActionView(title: String, image: Image, subtitle: String, customAction: OnboardingButtonConfiguration, theme: OnboardingColorTheme) -> some View {
        VStack {
            Text(title)
                .font(.title)
                .foregroundColor(theme.text)
            image
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(theme.text)
            button(for: customAction, theme: theme)
                .padding()
        }
    }
    
    @ViewBuilder
    private func button(for config: OnboardingButtonConfiguration, theme: OnboardingColorTheme) -> some View {
        Button(action: {
            switch config.type {
            case .skip:
                dismissOnboarding()
            case .next:
                if currentPage < configuration.pages.count - 1 {
                    trackAnalytics(configuration.pages[currentPage].analyticsEventExit)
                    currentPage += 1
                    trackAnalytics(configuration.pages[currentPage].analyticsEventEnter)
                } else {
                    dismissOnboarding()
                }
            case .openPaywall:
                openPaywall()
            case .custom(let action):
                action()
            }
        }) {
            Text(config.title)
                .foregroundColor(theme.background)
                .padding()
                .background(theme.primary)
                .cornerRadius(10)
        }
    }
    
    
    private func dismissOnboarding() {
       trackAnalytics(configuration.pages[currentPage].analyticsEventExit)
       isPresented = false
    }
    
    
    
}
    

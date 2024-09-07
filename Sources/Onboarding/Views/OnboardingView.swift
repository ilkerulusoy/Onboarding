//
//  OnboardingView.swift
//  Onboarding
//
//  Created by ilker on 6.09.2024.
//
import SwiftUI
import Extensions

struct OnboardingView: View {
    let configuration: OnboardingConfiguration
    @State private var currentPage = 0
    @State private var hapticCounter = 0
    var openPaywall: () -> Void
    let onOnboardingEnded: () -> Void
    let onOnboardingSkipped: () -> Void
    var trackAnalytics: (OnboardingAnalyticsEvent) -> Void
    
    var body: some View {
        let currentConfig = configuration.pages[currentPage]
        VStack {
            ProgressView(value: currentConfig.progressValue)
                .padding()
                .accentColor(currentConfig.colorTheme.primary)
                .opacity(currentConfig.isProgressEnable ? 1.0 : 0.0)
            
            Group {
                switch currentConfig.type {
                case .progressImageTitleSubtitle(let image, let title, let subtitle):
                    progressImageTitleSubtitleView(image: image, title: title, subtitle: subtitle, theme: currentConfig.colorTheme, progress: currentConfig.progressValue, totalPages: configuration.totalPages)
                case .progressTitleSelectionList(let title, let items):
                    progressTitleSelectionListView(title: title, items: items, theme: currentConfig.colorTheme)
                case .progressTitleTextField(let title, let placeholder):
                    progressTitleTextFieldView(title: title, placeholder: placeholder, theme: currentConfig.colorTheme)
                case .progressTitleImageSubtitleCustomAction(let title, let image, let subtitle, let customAction):
                    progressTitleImageSubtitleCustomActionView(title: title, image: image, subtitle: subtitle, customAction: customAction, theme: currentConfig.colorTheme)
                case .progressCustomView(let content):
                    content()
                }
            }
            .layoutPriority(2)
            
            Spacer()
            
            HStack {
                if let buttonConfig =  currentConfig.bottomLeftButton {
                    button(for: buttonConfig, theme: currentConfig.colorTheme)
                        .layoutPriority(1)
                }
                Spacer()
                if let buttonConfig = currentConfig.bottomRightButton {
                    button(for: buttonConfig, theme: currentConfig.colorTheme)
                        .layoutPriority(1)
                }

            }
            
            .padding(.horizontal)
        }
        .background(currentConfig.colorTheme.background)
        .overlay(alignment: .topTrailing, content: {
            currentConfig.topRightButton != nil ?
            rightCornerButton(for: currentConfig.topRightButton!, theme: currentConfig.colorTheme)
                .padding()
                .padding(.top, 10)
            : nil
        })
        .onAppear {
            trackAnalytics(currentConfig.analyticsEventEnter)
        }
        .onDisappear {
            trackAnalytics(currentConfig.analyticsEventExit)
        }
    }
    
    @ViewBuilder
    private func progressImageTitleSubtitleView(image: Image, title: String, subtitle: String, theme: OnboardingColorTheme, progress: Float, totalPages: Int) -> some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                GeometryReader { geometry in
                    image
                        .resizable()
//                        .fixedSize(horizontals: false, vertical: true)
                        .aspectRatio(contentMode: .fill)
                        .scaledToFill()
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height)
                        .clipped()
                    
                }

                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text(title)
                            .font(.title)
                            .lineLimit(4, reservesSpace: false)
                            .fontWeight(.bold)
                            .foregroundColor(theme.text)
                        Spacer()
                    }
                    
                    HStack {
                        
                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundColor(theme.text.opacity(0.7))
                        Spacer()
                    }
                }
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                .layoutPriority(2)
                .padding(24)
            }
        }
        .frame(maxWidth: .infinity)
        .background(theme.background)
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
    private func rightCornerButton(for config: OnboardingButtonConfiguration, theme: OnboardingColorTheme) -> some View {
        Button(action: {
            switch config.type {
            case .skip:
                skipOnboarding()
                break
            case .next:
                if currentPage < configuration.pages.count - 1 {
                    trackAnalytics(configuration.pages[currentPage].analyticsEventExit)
                    currentPage += 1
                    trackAnalytics(configuration.pages[currentPage].analyticsEventEnter)
                } else {
                    dismissOnboarding()
                }
                break
            case .back:
                if currentPage > 0 {
                    trackAnalytics(configuration.pages[currentPage].analyticsEventExit)
                    currentPage -= 1
                    trackAnalytics(configuration.pages[currentPage].analyticsEventEnter)
                }
                break
            case .openPaywall:
                openPaywall()
                break
            case .custom(let action):
                action()
                break
            }
        }) {
            ZStack {
                Circle()
                    .fill(theme.primary)
                    .frame(width: 50, height: 50)
                
                Image(systemName: "xmark")
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundColor(theme.background)
            }
            .padding(8)
            .contentShape(Circle())
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel(Text("Close"))
        
        
    }
    
    @ViewBuilder
    private func button(for config: OnboardingButtonConfiguration, theme: OnboardingColorTheme) -> some View {
        // Next button (placeholder)
        Button(action: {
            hapticCounter = hapticCounter + 1
            switch config.type {
            case .skip:
                skipOnboarding()
                break
            case .next:
                if currentPage < configuration.pages.count - 1 {
                    trackAnalytics(configuration.pages[currentPage].analyticsEventExit)
                    currentPage += 1
                    trackAnalytics(configuration.pages[currentPage].analyticsEventEnter)
                } else {
                    dismissOnboarding()
                }
                break
            case .back:
                if currentPage > 0 {
                    trackAnalytics(configuration.pages[currentPage].analyticsEventExit)
                    currentPage -= 1
                    trackAnalytics(configuration.pages[currentPage].analyticsEventEnter)
                }
                break
            case .openPaywall:
                openPaywall()
                break
            case .custom(let action):
                action()
            }
        }) {
            ZStack {
                Rectangle()
                    .fill(theme.primary)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                
                Text(config.title)
                    .fixedSize()
                    .frame(height: 50)
                    .font(.custom("Inter", size: 16).weight(.semibold))
                    .foregroundColor(theme.background)
            }
        }
        .hapticFeedback(style: .increase, trigger: $hapticCounter)
        
    }
    
    private func skipOnboarding() {
        trackAnalytics(OnboardingAnalyticsEvent(name: "onboarding_skipped", parameters: [:]))
        onOnboardingSkipped()
    }
    
    private func dismissOnboarding() {
        trackAnalytics(configuration.pages[currentPage].analyticsEventExit)
        trackAnalytics(OnboardingAnalyticsEvent(name: "onboarding_ended", parameters: [:]))
        onOnboardingEnded()
    }
    
}

#Preview {
    OnboardingView(configuration:  OnboardingConfiguration(pages: [
        OnboardingPageConfiguration(
               type: .progressImageTitleSubtitle(
                image: Image(systemName: "star"),
                   title: "Welcome to personalized AI-based daily Horoscope",
                   subtitle: "Discover your unique daily horoscope crafted just for you by our advanced AI. Tailored insights and cosmic guidance are just a tap away, making your day more aligned with the stars."
               ),
               progressValue: 0.2, // Current page number
               colorTheme: OnboardingColorTheme(
                   primary: Color(red: 0.11, green: 0.13, blue: 0.18),
                   secondary: Color(red: 0.44, green: 0.45, blue: 0.48),
                   background: Color(red: 0.96, green: 0.91, blue: 0.82),
                   text: .black
               ),
               isProgressEnable: false,
               topRightButton: OnboardingButtonConfiguration(type: .skip, title: "Skip"),
               bottomLeftButton: nil,
               bottomRightButton: OnboardingButtonConfiguration(type: .next, title: "Next"),
               analyticsEventEnter: OnboardingAnalyticsEvent(name: "onboarding_welcome_enter", parameters: [:]),
               analyticsEventExit: OnboardingAnalyticsEvent(name: "onboarding_welcome_exit", parameters: [:])
        ),
        OnboardingPageConfiguration(
            type: .progressImageTitleSubtitle(
                image: Image("onboarding1"),
                title: "Welcome",
                subtitle: "Get started with our app"
            ),
            progressValue: 0.25,
            colorTheme: OnboardingColorTheme(
                primary: .blue,
                secondary: .gray,
                background: .white,
                text: .black
            ),
            isProgressEnable: true,
            topRightButton: OnboardingButtonConfiguration(type: .skip, title: "Skip"),
            bottomLeftButton: OnboardingButtonConfiguration(type: .back, title: "Back"),
            bottomRightButton: OnboardingButtonConfiguration(type: .next, title: "Next"),
            analyticsEventEnter: OnboardingAnalyticsEvent(name: "onboarding_welcome_enter", parameters: [:]),
            analyticsEventExit: OnboardingAnalyticsEvent(name: "onboarding_welcome_exit", parameters: [:])
        ),
        OnboardingPageConfiguration(
            type: .progressCustomView {
                AnyView(
                    VStack {
                        Text("This is a custom view")
                            .font(.title)
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text("You can add any SwiftUI content here")
                            .font(.subheadline)
                    }
                )
            },
            progressValue: 0.5,
            colorTheme: OnboardingColorTheme(
                primary: .green,
                secondary: .yellow,
                background: .white,
                text: .black
            ),
            isProgressEnable: true,
            topRightButton: OnboardingButtonConfiguration(type: .skip, title: "Skip"),
            bottomLeftButton: nil,
            bottomRightButton: OnboardingButtonConfiguration(type: .next, title: "Next"),
            analyticsEventEnter: OnboardingAnalyticsEvent(name: "onboarding_custom_enter", parameters: [:]),
            analyticsEventExit: OnboardingAnalyticsEvent(name: "onboarding_custom_exit", parameters: [:])
        )
    ]), openPaywall: {
        
    }, onOnboardingEnded: {
        
    }, onOnboardingSkipped: {
        
    }, trackAnalytics: { _ in })
}
    

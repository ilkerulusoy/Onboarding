# Onboarding

A flexible and customizable onboarding solution for iOS apps built with SwiftUI.

## Features

- Multiple onboarding page types
- Customizable colors and themes
- Progress tracking
- Analytics event tracking
- Paywall integration
- Custom view support

## Requirements

- iOS 16.0+
- Xcode 15.0+
- Swift 5.3+

## Installation

### Swift Package Manager

You can install Onboarding using the [Swift Package Manager](https://swift.org/package-manager/).

1. In Xcode, open your project and navigate to File → Swift Packages → Add Package Dependency.
2. Enter the repository URL: https://github.com/ilkerulusoy/Onboarding.git
3. For Version, select "Up to Next Major" with "1.0.0".

## Usage

1. Import the package in your SwiftUI view:

```swift
import Onboarding
```

2. Create an `OnboardingConfiguration`:

```swift
let configuration = OnboardingConfiguration(pages: [
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
        topRightButton: OnboardingButtonConfiguration(type: .skip, title: "Skip"),
        bottomLeftButton: OnboardingButtonConfiguration(type: .custom(action: {}), title: "Learn More"),
        bottomRightButton: OnboardingButtonConfiguration(type: .next, title: "Next"),
        analyticsEventEnter: OnboardingAnalyticsEvent(name: "onboarding_welcome_enter", parameters: [:]),
        analyticsEventExit: OnboardingAnalyticsEvent(name: "onboarding_welcome_exit", parameters: [:])
    ),
    // Add more pages as needed
])
```

3. Present the onboarding view:

```swift
struct ContentView: View {
    @State private var showOnboarding = false

    var body: some View {
        Button("Show Onboarding") {
            showOnboarding = true
        }
        .sheet(isPresented: $showOnboarding) {
            OnboardingContainerView(
                isOnboardingPresented: $showOnboarding,
                configuration: configuration,
                openPaywall: {
                    // Handle opening paywall
                },
                trackAnalytics: { event in
                    // Handle analytics tracking
                }
            )
        }
    }
}
```

## Customization

You can customize the appearance and behavior of the onboarding flow by modifying the `OnboardingConfiguration` and `OnboardingPageConfiguration` objects.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

Onboarding is available under the MIT license. See the LICENSE file for more info.

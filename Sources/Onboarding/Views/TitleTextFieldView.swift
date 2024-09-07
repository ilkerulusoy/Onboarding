import SwiftUI

public struct TitleTextFieldView: View {
    let title: String
    let subtitle: String
    let placeholder: String
    let theme: OnboardingColorTheme
    let onTextChanged: ((String) -> Void)?
    
    @State private var text: String = ""
    @State private var hapticCounter: Int = 0
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
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
                .layoutPriority(2)
                .padding()
                
                VStack(spacing: 16) {
                    TextField(placeholder, text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(theme.secondary.opacity(0.6))
                        .cornerRadius(10)
                        .foregroundColor(theme.text)
                        .onChange(of: text) { newValue in
                            hapticCounter += 1
                            onTextChanged?(newValue)
                        }
                        .hapticFeedback(style: .success, trigger: $hapticCounter)
                }
                .padding(.horizontal)
            }
            .background(theme.background)
        }
        .padding(.bottom, 10)
    }
}
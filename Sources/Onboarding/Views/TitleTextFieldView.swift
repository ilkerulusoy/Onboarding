//
//  TitleTextFieldView.swift
//  Onboarding
//
//  Created by ilker on 7.09.2024.
//
import SwiftUI

public struct TitleTextFieldView: View {
    let title: String
    let subtitle: String
    let placeholder: String
    let theme: OnboardingColorTheme
    let onTextChanged: ((String) -> Void)?
    
    @State private var text: String = ""
    
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
                .padding(.horizontal)
                .padding(.top)
                
                TextField(placeholder, text: $text, axis: .vertical)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .lineLimit(15, reservesSpace: true)
                    .padding()
                    .cornerRadius(10)
                    .foregroundColor(theme.text)
                    .onChange(of: text) { newValue in
                        onTextChanged?(newValue)
                    }
            }
            .background(theme.background)
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    TitleTextFieldView(
        title: "Would You Like to Share More About Yourself?",
        subtitle: "Tell us more to help us tailor your horoscope experience even better. Your insights will stay confidential.",
        placeholder: "I am a aries",
        theme: OnboardingColorTheme.defaultColorTheme,
        onTextChanged: { _ in
        
    })
}

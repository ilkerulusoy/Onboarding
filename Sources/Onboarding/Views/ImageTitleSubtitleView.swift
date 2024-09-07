//
//  ImageTitleSubtitleView.swift
//  Onboarding
//
//  Created by ilker on 7.09.2024.
//


import SwiftUI

public struct ImageTitleSubtitleView: View {
    let image: Image
    let title: String
    let subtitle: String
    let theme: OnboardingColorTheme
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                GeometryReader { geometry in
                    image
                        .resizable()
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
}

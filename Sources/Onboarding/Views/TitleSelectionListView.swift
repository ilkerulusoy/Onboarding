//
//  TitleSelectionListView.swift
//  Onboarding
//
//  Created by ilker on 7.09.2024.
//
import SwiftUI

public struct TitleSelectionListView: View {
    let title: String
    let subtitle:String
    let items: [OnboardingSelectionItem]
    let gridCount: Int
    let theme: OnboardingColorTheme
    let onItemSelected: ((OnboardingSelectionItem) -> Void)?
    
    @State var selectedItem: OnboardingSelectionItem? = nil
    @State var hapticCounter: Int = 0
    
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
                
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(
                            .flexible(),
                            spacing: 16
                        ),
                        count: gridCount
                    ),
                    spacing: 16
                ) {
                    ForEach(items) { item in
                        Button(action: {
                            hapticCounter += 1
                            selectedItem = item
                            onItemSelected?(item)
                        }) {
                            HStack {
                                Spacer()
                                VStack(spacing: 8) {
                                    item.icon
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                    Text(item.title)
                                        .font(.headline)
                                    Text(item.subtitle)
                                        .font(.caption)
                                        .multilineTextAlignment(.center)
                                }
                                .padding()
                                Spacer()
                               
                            }
                            .frame(height:150)
                            .background(selectedItem == item ? theme.secondary : theme.secondary.opacity(0.6))
                            .cornerRadius(10)
                            .foregroundColor(theme.text)
                        }
                        .hapticFeedback(style: .success, trigger: $hapticCounter)
                    }
                }
                .padding(.horizontal)
            }
            .background(theme.background)
        }
        .padding(.bottom, 10)
    }
}

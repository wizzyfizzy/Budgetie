//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import SwiftUI
import UIComponents

public struct OnboardingView: View {
    @StateObject private var viewModel: OnboardingVM
    @Environment(\.dismiss) private var dismiss

    private let imageHeight: CGFloat = 200
    
    public init() {
        _viewModel = StateObject(wrappedValue: OnboardingVM())
    }
    private let background = LinearGradient(colors: [Color.btLightGreen, Color.btLightYellow],
                                            startPoint: .top, endPoint: .bottom)

    public var body: some View {        
        VStack {
            Spacer()
            TabView(selection: $viewModel.currentStep) {
                ForEach(Array(viewModel.onboardingSteps.enumerated()), id: \.element.id) { index, step in
                    VStack(spacing: Spacing.spaceM) {
                        Image(step.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: imageHeight)
                        
                        Text(step.title)
                            .font(.appTitle)
                            .foregroundColor(.btBlack)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)
                        
                        Text(step.description)
                            .font(.appBody)
                            .foregroundColor(.btBlack)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .tag(index)
                }
            }
            .padding(.horizontal, Spacing.spaceL)
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            Spacer()
            Pager(currentPage: $viewModel.currentStep,
                  numberOfPages: viewModel.onboardingSteps.count)
            .padding(.bottom, Spacing.spaceL)
            
            HStack(spacing: Spacing.spaceM) {
                if !viewModel.isLastStep {
                    TextButton(text: viewModel.textButtonSkip) {
                        withAnimation {
                            viewModel.skipOnboarding()
                            dismiss()
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
                GradientButton(text: viewModel.isLastStep ? viewModel.textButtonGetStarted : viewModel.textButtonNext) {
                    if viewModel.isLastStep {
                        viewModel.completeOnboarding()
                        dismiss()
                    } else {
                        viewModel.nextStep()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(background)
        .onAppear {
            viewModel.startAutoScroll()
            viewModel.trackView()
        }
        .onDisappear {
            viewModel.stopTimer()
        }
    }
}

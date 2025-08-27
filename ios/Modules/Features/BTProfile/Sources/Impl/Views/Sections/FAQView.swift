//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import SwiftUI

// MARK: - Models
struct FAQItem: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

struct FAQSection: Identifiable {
    let id = UUID()
    let title: String
    let items: [FAQItem]
}

// MARK: - View
struct FAQView: View {
    private let sections: [FAQSection] = [
        FAQSection(
            title: TextKeys.textProfileFaqGettingStartedTitle,
            items: [
                FAQItem(
                    question: TextKeys.textProfileFaqGettingStartedQuestion1,
                    answer: TextKeys.textProfileFaqGettingStartedAnswer1
                ),
                FAQItem(
                    question: TextKeys.textProfileFaqGettingStartedQuestion2,
                    answer: TextKeys.textProfileFaqGettingStartedAnswer2
                )
            ]
        ),
        FAQSection(
            title: TextKeys.textProfileFaqSubscriptionsTitle,
            items: [
                FAQItem(
                    question: TextKeys.textProfileFaqSubscriptionsQuestion1,
                    answer: TextKeys.textProfileFaqSubscriptionsAnswer1
                ),
                FAQItem(
                    question: TextKeys.textProfileFaqSubscriptionsQuestion2,
                    answer: TextKeys.textProfileFaqSubscriptionsAnswer2
                ),
                FAQItem(
                    question: TextKeys.textProfileFaqSubscriptionsQuestion3,
                    answer: TextKeys.textProfileFaqSubscriptionsAnswer3
                )
            ]
        ),
        FAQSection(
            title: TextKeys.textProfileFaqFeaturesTitle,
            items: [
                FAQItem(
                    question: TextKeys.textProfileFaqFeaturesQuestion1,
                    answer: TextKeys.textProfileFaqFeaturesAnswer1
                ),
                FAQItem(
                    question: TextKeys.textProfileFaqFeaturesQuestion2,
                    answer: TextKeys.textProfileFaqFeaturesAnswer2
                ),
                FAQItem(
                    question: TextKeys.textProfileFaqFeaturesQuestion3,
                    answer: TextKeys.textProfileFaqFeaturesAnswer3
                )
            ]
        ),
        FAQSection(
            title: TextKeys.textProfileFaqSecurityTitle,
            items: [
                FAQItem(
                    question: TextKeys.textProfileFaqSecurityQuestion1,
                    answer: TextKeys.textProfileFaqSecurityAnswer1
                ),
                FAQItem(
                    question: TextKeys.textProfileFaqSecurityQuestion2,
                    answer: TextKeys.textProfileFaqSecurityAnswer2
                ),
                FAQItem(
                    question: TextKeys.textProfileFaqSecurityQuestion3,
                    answer: TextKeys.textProfileFaqSecurityAnswer3
                )
            ]
        )
    ]
    
    var body: some View {
        List {
            ForEach(sections) { section in
                Section(header:
                    Text(LocalizedStringKey(section.title))
                        .font(.appTitle2)
                        .foregroundColor(.btGray)
                        .accessibilityAddTraits(.isHeader)
                ) {
                    ForEach(section.items) { item in
                        let answerAccessibilityLabel = "\(LocalizedStringKey(TextKeys.textProfileFaqAccessibilityAnswer)): \(item.answer)"
                        let questionAccessibilityLabel = "\(LocalizedStringKey(TextKeys.textProfileFaqAccessibilityQuestion)): \(item.answer)"

                        DisclosureGroup {
                            Text(LocalizedStringKey(item.answer))
                                .font(.appBody)
                                .foregroundColor(.btBlack)
                                .accessibilityLabel(answerAccessibilityLabel)
                        } label: {
                            Text(LocalizedStringKey(item.question))
                                .font(.appBody)
                                .foregroundColor(.btBlack)
                                .bold()
                                .accessibilityLabel(questionAccessibilityLabel)
                                .accessibilityAddTraits(.isButton)
                        }
                    }
                }
            }
        }
        .navigationTitle(LocalizedStringKey(TextKeys.textProfileFAQ))
    }
}

//
// Copyright © 2019 ___ORGANIZATIONNAME___
// All rights reserved.
//

import Combine
import Foundation

public struct FormValidator {
    public static func emailPublisher(_ email: Published<String>.Publisher) -> AnyPublisher<String?, Never> {
        email
            .map { email in
                if email.isEmpty {
                    return "Please fill in your email."
                }
                if !email.isValidEmail {
                    return "Invalid email format."
                }
                return nil
            }
            .eraseToAnyPublisher()
    }
    
    public static func namePublisher(_ name: Published<String>.Publisher) -> AnyPublisher<String?, Never> {
        name
            .removeDuplicates()
            .map { name in
                if name.isEmpty {
                    return "Please fill in your name."
                } else if name.count < 2 {
                    return "Name must have at least 2 characters."
                }
                return nil
            }
            .eraseToAnyPublisher()
    }
    
    public static func agreeTermsPublisher(_ agreeTerms: Published<Bool>.Publisher) -> AnyPublisher<String?, Never> {
        agreeTerms
            .removeDuplicates()
            .map { agreeTerms in
                if !agreeTerms {
                    return "Please accept Terms and conditions"
                }
                return nil
            }
            .eraseToAnyPublisher()
    }
    
    public static func passwordPublisher(_ password: Published<String>.Publisher, confirmPassword: Published<String>.Publisher) -> AnyPublisher<String?, Never> {
        Publishers.CombineLatest(password, confirmPassword)
            .map { password, confirmPassword in
                if password.count < 6 {
                    return "Password must have at least 6 characters."
                } else if password != confirmPassword {
                    return "Passwords do not match."
                }
                return nil
            }
            .eraseToAnyPublisher()
    }
}

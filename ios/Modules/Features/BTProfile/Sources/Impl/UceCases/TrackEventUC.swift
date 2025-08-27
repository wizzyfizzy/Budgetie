
import UIComponents

// sourcery: AutoMockable
/// Handles the "Forgot Password" feature.
protocol TrackEventUC {
    /// Sends a reset password email.
    /// - Parameters:
    ///   - email: User's email.
    /// - Returns: A success message string.
    /// - Throws: Errors if the email is invalid or the network call fails.
//    func execute() async throws -> String
}

class TrackEventUCImpl: TrackEventUC {
//    @Injected private var repo: AuthAPIRepo

//    func execute(email: String) async throws -> String {
//        try await repo.forgotPassword(email: email)
//    }
}

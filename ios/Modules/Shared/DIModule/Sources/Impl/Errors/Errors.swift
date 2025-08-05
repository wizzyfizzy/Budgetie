//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation

// the default fatalError provided by swift
private let defaultFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }

// the default fatalError provided by swift
private var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure

/// A testable global `fatalError` override.
func fatalError(_ message: @autoclosure () -> String = String(),
                file: StaticString = #file,
                line: UInt = #line) -> Never {
    fatalErrorClosure(message(), file, line)
}

#if DEBUG
// Only for testing purposes

/// Uses the given `closure` as replacement for `fatalError()`.
public func overrideFatalError(_ newClosure: @escaping (String, StaticString, UInt) -> Never) {
    fatalErrorClosure = newClosure
}

/// Restores `fatalError()` to the default Swift implementation.
public func restoreFatalError() {
    fatalErrorClosure = defaultFatalErrorClosure
}
#endif


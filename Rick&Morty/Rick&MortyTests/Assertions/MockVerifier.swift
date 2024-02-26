import XCTest

protocol MockVerifier: AnyObject { }

extension MockVerifier {
    @discardableResult
    func verifyMethodCalledOnce(
        methodName: String,
        callCount: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Bool {
        guard callCount > 0 else {
            XCTFail(failMessageForNotInvoked(methodName), file: file, line: line)
            return false
        }

        guard callCount == 1 else {
            XCTFail(failMessageForCalledMoreThanOnce(methodName, callCount: callCount), file: file, line: line)
            return false
        }

        return true
    }

    @discardableResult
    func verifyMethodCalledOnce(
        methodName: String,
        callCount: Int,
        describeArguments: @autoclosure () -> String,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Bool {
        guard callCount > 0 else {
            XCTFail(failMessageForNotInvoked(methodName), file: file, line: line)
            return false
        }

        guard callCount == 1 else {
            XCTFail(
                failMessageForCalledMoreThanOnce(methodName, callCount: callCount, describeArguments: describeArguments()),
                file: file,
                line: line
            )
            return false
        }

        return true
    }

    @discardableResult
    func verifyMethodNeverCalled(
        methodName: String,
        callCount: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Bool {
        guard callCount == 0 else {
            XCTFail(failMessageForNeverCalled(methodName, callCount: callCount), file: file, line: line)
            return false
        }

        return true
    }

    @discardableResult
    func verifyMethodNeverCalled(
        methodName: String,
        callCount: Int,
        describeArguments: @autoclosure () -> String,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Bool {
        guard callCount == 0 else {
            XCTFail(
                failMessageForNeverCalled(methodName, callCount: callCount, describeArguments: describeArguments()),
                file: file,
                line: line
            )
            return false
        }

        return true
    }
}

// MARK: - Private
private extension MockVerifier {
    func failMessageForNotInvoked(_ methodName: String) -> String {
        "Wanted but not invoked: \(methodName)"
    }

    func failMessageForCalledMoreThanOnce(
        _ methodName: String,
        callCount: Int,
        describeArguments: String? = nil
    ) -> String {
        guard let describeArguments = describeArguments else {
            return "Wanted 1 time but was called \(callCount) times: \(methodName)."
        }

        return "Wanted 1 time but was called \(callCount) times. \(methodName) with \(describeArguments)."
    }

    func failMessageForNeverCalled(
        _ methodName: String,
        callCount: Int,
        describeArguments: String? = nil
    ) -> String {
        guard let describeArguments = describeArguments else {
            return "Wanted never but was called \(callCount) times: \(methodName)."
        }

        return "Wanted never but was called \(callCount) times. \(methodName) with \(describeArguments)."
    }
}

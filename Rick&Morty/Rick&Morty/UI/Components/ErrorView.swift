import SwiftUI

// MARK: - ErrorView

struct ErrorView: View {

    init(error: Error, tryAgainAction: (() -> Void)? = nil) {
        self.error = error
        self.tryAgainAction = tryAgainAction
    }

    var body: some View {
        VStack(spacing: 16.0) {
            VStack {
                Text("Something wrong happened!")
                    .font(.title)
                
                Text("**Reason**: \(error.localizedDescription)")
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }

            VStack {
                Text("Would you like to try again?")
                    .font(.headline)

                Button("Try again") {
                    tryAgainAction?()
                }
            }
        }
    }

    private let error: Error
    private let tryAgainAction: (() -> Void)?
}

#Preview {
    ErrorView(
        error: NetworkError.unknown,
        tryAgainAction: {
            print("Trying again!")
        })
}

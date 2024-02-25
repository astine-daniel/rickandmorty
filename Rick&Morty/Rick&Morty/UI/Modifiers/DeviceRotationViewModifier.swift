import Foundation
import SwiftUI

// MARK: - DeviceRotationViewModifier

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(
                NotificationCenter.default.publisher(
                    for: UIDevice.orientationDidChangeNotification
                ),
                perform: { _ in
                    action(UIDevice.current.orientation)
                }
            )
    }
}

// MARK: View extension

extension View {
    func onOrientationChanged(_ action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        modifier(DeviceRotationViewModifier(action: action))
    }
}

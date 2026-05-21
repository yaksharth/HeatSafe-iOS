import Foundation
import Combine

public class AppCoordinator: ObservableObject {
    
    // Unified Screens order matching both onboarding and production mockup views
    public let screens = [
        "onboarding",
        "climate",
        "hydrationIntro",
        "permissions",
        "home",
        "heat",
        "hydration",
        "symptoms",
        "session"
    ]
    
    @Published public var currentScreen: String = "onboarding" {
        didSet {
            print("Current screen: \(currentScreen)")
        }
    }
    
    public init() {
        print("Current screen: \(currentScreen)")
    }
    
    /// Cycles to the next onboarding step
    public func next() {
        if let currentIndex = screens.firstIndex(of: currentScreen) {
            let nextIndex = currentIndex + 1
            if nextIndex < screens.count {
                currentScreen = screens[nextIndex]
            }
        }
    }
    
    /// Checks if a screen falls within onboarding steps
    public var isOnboarding: Bool {
        return ["onboarding", "climate", "hydrationIntro", "permissions"].contains(currentScreen)
    }
    
    /// Direct router
    public func setScreen(_ screen: String) {
        if screens.contains(screen) {
            currentScreen = screen
        }
    }
}

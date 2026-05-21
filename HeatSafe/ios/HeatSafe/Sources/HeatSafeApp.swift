import SwiftUI

@main
struct HeatSafeApp: App {
    // Instantiates the global state coordinator for routing and transitions
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            AppShell(coordinator: coordinator)
                .preferredColorScheme(.light) // Lock to light theme to match design specs
        }
    }
}

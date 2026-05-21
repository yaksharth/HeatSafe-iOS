import SwiftUI

public struct AppShell: View {
    @ObservedObject var coordinator: AppCoordinator
    
    public init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        ZStack {
            // Desktop outer layout preview canvas (matches #F0EDE8)
            Theme.desktopBackground
                .ignoresSafeArea()
            
            // Canvas floating warm aesthetic orbs
            ZStack {
                Circle()
                    .fill(Color(hex: "FF8C5A").opacity(0.12))
                    .frame(width: 550, height: 550)
                    .blur(radius: 80)
                    .position(x: 750, y: 150)
                
                Circle()
                    .fill(Color(hex: "4AACDE").opacity(0.08))
                    .frame(width: 480, height: 480)
                    .blur(radius: 80)
                    .position(x: -80, y: 700)
            }
            .ignoresSafeArea()
            
            // Physical Device frame
            VStack {
                Spacer()
                
                ZStack(alignment: .bottom) {
                    // Device Screen
                    ZStack(alignment: .top) {
                        // Soft warm solid background for phone mockup (#FBF8F4)
                        Theme.phoneBackground
                            .ignoresSafeArea()
                        
                        // Current View Router
                        Group {
                            switch coordinator.currentScreen {
                            case "onboarding":
                                OnboardingView(coordinator: coordinator)
                            case "climate":
                                ClimateView(coordinator: coordinator)
                            case "hydrationIntro":
                                HydrationIntroView(coordinator: coordinator)
                            case "permissions":
                                PermissionsView(coordinator: coordinator)
                            case "home":
                                HomeView(coordinator: coordinator)
                            case "heat":
                                HeatView(coordinator: coordinator)
                            case "hydration":
                                HydrationView(coordinator: coordinator)
                            case "symptoms":
                                SymptomsView(coordinator: coordinator)
                            case "session":
                                SessionView(coordinator: coordinator)
                            default:
                                HomeView(coordinator: coordinator)
                            }
                        }
                        .transition(.asymmetric(
                            insertion: .opacity.combined(with: .move(edge: .trailing)),
                            removal: .opacity.combined(with: .move(edge: .leading))
                        ))
                        .padding(.top, 44) // make safe space for iOS simulated notch/status bar
                        
                        // Simulated iOS Status Bar (faithfully displaying 9:41)
                        HStack {
                            Text("9:41")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(Theme.textPrimary)
                            
                            Spacer()
                            
                            HStack(spacing: 5) {
                                // Customized cellular SVG icon simulation
                                Image(systemName: "cellularbars")
                                    .font(.system(size: 12, weight: .bold))
                                Image(systemName: "wifi")
                                    .font(.system(size: 12, weight: .bold))
                                Image(systemName: "battery.100")
                                    .font(.system(size: 15, weight: .regular))
                            }
                            .foregroundColor(Theme.textPrimary)
                        }
                        .padding(.horizontal, 28)
                        .padding(.top, 16)
                        .zIndex(100)
                        
                        // Device Bezel Notch
                        HStack {
                            Spacer()
                            Capsule()
                                .fill(Color.black.opacity(0.85))
                                .frame(width: 126, height: 34)
                                .padding(.top, 0)
                                .overlay(
                                    HStack(spacing: 6) {
                                        Circle()
                                            .fill(Color(hex: "2A2A2A"))
                                            .frame(width: 10, height: 10)
                                        Capsule()
                                            .fill(Color(hex: "2A2A2A"))
                                            .frame(width: 60, height: 6)
                                    }
                                )
                            Spacer()
                        }
                        .zIndex(101)
                    }
                    .frame(width: 375, height: 812) // Perfect iOS Aspect Frame matching mock frame size (375px)
                    .clipShape(RoundedRectangle(cornerRadius: 44))
                    
                    // Device Bottom Navigation Bar Overlay (Toggled off during onboarding)
                    if !coordinator.isOnboarding {
                        VStack(spacing: 0) {
                            // Exact Tab Items matching HTML tab bar
                            HStack(spacing: 0) {
                                tabButton(id: "home", icon: "house.fill", label: "Home")
                                tabButton(id: "heat", icon: "thermometer", label: "Heat")
                                tabButton(id: "hydration", icon: "drop.fill", label: "Hydrate")
                                tabButton(id: "symptoms", icon: "heart.fill", label: "Health")
                            }
                            .padding(.top, 11)
                            .padding(.bottom, 20)
                            .background(Color(hex: "FBF8F4").opacity(0.97))
                            .overlay(
                                Divider()
                                    .background(Color.black.opacity(0.09)),
                                alignment: .top
                            )
                            
                            // Native Safe Area Home Indicator Pill
                            ZStack {
                                Color(hex: "FBF8F4")
                                    .frame(height: 12)
                                
                                Capsule()
                                    .fill(Color.black.opacity(0.8))
                                    .frame(width: 134, height: 5)
                                    .padding(.bottom, 4)
                            }
                        }
                        .frame(width: 375)
                        .zIndex(200)
                    } else {
                        // Onboarding safe area indicator
                        ZStack {
                            Color.clear
                                .frame(height: 16)
                            Capsule()
                                .fill(Color.black.opacity(0.3))
                                .frame(width: 134, height: 5)
                                .padding(.bottom, 4)
                        }
                        .frame(width: 375)
                        .zIndex(200)
                    }
                }
                .frame(width: 375, height: 812)
                .background(Theme.phoneBackground)
                .clipShape(RoundedRectangle(cornerRadius: 44))
                .overlay(
                    RoundedRectangle(cornerRadius: 44)
                        .stroke(Color.black.opacity(0.1), lineWidth: 1.5)
                )
                .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
                .shadow(color: Color.black.opacity(0.08), radius: 24, x: 0, y: 8)
                .shadow(color: Color.black.opacity(0.06), radius: 48, x: 0, y: 24)
                
                Spacer()
            }
            .padding(.vertical, 16)
        }
    }
    
    // Tab Button creator
    @ViewBuilder
    private func tabButton(id: String, icon: String, label: String) -> some View {
        // Evaluate active state
        // In the mock design, "session" is considered a sub-page, so no tab highlights when session is open
        let isSelected = coordinator.currentScreen == id
        
        Button(action: {
            withAnimation(.spring(response: 0.38, dampingFraction: 0.75)) {
                coordinator.setScreen(id)
            }
        }) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? Theme.brandOrange : Color(hex: "C0B5AD"))
                
                Text(label)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(isSelected ? Theme.brandOrange : Color(hex: "C0B5AD"))
                
                if isSelected {
                    // Small active orange dot
                    Circle()
                        .fill(Theme.brandOrange)
                        .frame(width: 4, height: 4)
                        .padding(.top, 2)
                } else {
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 4, height: 4)
                        .padding(.top, 2)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct AppShell_Previews: PreviewProvider {
    static var previews: some View {
        AppShell(coordinator: AppCoordinator())
    }
}

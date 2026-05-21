import SwiftUI

struct PermissionsView: View {
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        ZStack {
            // Background cream gradient
            Theme.cream
                .ignoresSafeArea()
            
            // Content
            VStack(alignment: .leading, spacing: 0) {
                // Typography Section
                Text("Personalize your\ndaily wellness\nexperience.")
                    .font(.system(size: 40, weight: .semibold, design: .default))
                    .lineSpacing(-2)
                    .tracking(-1.8)
                    .foregroundColor(Theme.textPrimary)
                    .minimumScaleFactor(0.85)
                    .padding(.top, 40)
                    .fixedSize(horizontal: false, vertical: true)
                
                // Permission Card Items
                VStack(spacing: 16) {
                    permissionRow(
                        icon: "location.fill",
                        iconColor: Color(hex: "FF9E57"),
                        title: "Location Access",
                        description: "Real-time heat awareness and environmental conditions"
                    )
                    
                    permissionRow(
                        icon: "bell.fill",
                        iconColor: Color(hex: "5DA5FF"),
                        title: "Notifications",
                        description: "Hydration reminders and outdoor safety guidance"
                    )
                    
                    permissionRow(
                        icon: "heart.fill",
                        iconColor: Color(hex: "FF6B6B"),
                        title: "Health Tracking",
                        description: "Personal hydration insights and wellness patterns"
                    )
                }
                .padding(.top, 36)
                
                Spacer()
                
                // Bottom Buttons
                VStack(spacing: 12) {
                    // Custom indicators
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color(hex: "DDD5CC"))
                            .frame(width: 8, height: 8)
                        
                        Circle()
                            .fill(Color(hex: "DDD5CC"))
                            .frame(width: 8, height: 8)
                        
                        Circle()
                            .fill(Color(hex: "DDD5CC"))
                            .frame(width: 8, height: 8)
                        
                        Capsule()
                            .fill(Theme.accentOrange)
                            .frame(width: 48, height: 8)
                    }
                    .padding(.bottom, 16)
                    
                    // Primary Action: Get Started
                    Button(action: {
                        print("Navigating to home")
                        withAnimation(.spring(response: 0.55, dampingFraction: 0.8)) {
                            coordinator.setScreen("home")
                        }
                    }) {
                        Text("Get Started")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Theme.textPrimary)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .shadow(color: Color.black.opacity(0.12), radius: 20, x: 0, y: 15)
                    }
                    .buttonStyle(ScaleButtonStyle())
                    
                    // Secondary Action: Maybe Later
                    Button(action: {
                        print("Navigating to home (maybe later)")
                        withAnimation(.spring(response: 0.55, dampingFraction: 0.8)) {
                            coordinator.setScreen("home")
                        }
                    }) {
                        Text("Maybe Later")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(Color(hex: "5F5750"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.white.opacity(0.6))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.white.opacity(0.4), lineWidth: 1)
                            )
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 36)
        }
    }
    
    // Custom permission row view helper
    @ViewBuilder
    private func permissionRow(icon: String, iconColor: Color, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 20) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(iconColor)
                .frame(width: 56, height: 56)
                .background(Color(hex: "F8F3ED"))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Theme.textPrimary)
                
                Text(description)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Theme.textSecondary)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
        }
        .padding(20)
        .glassCard(cornerRadius: 30)
    }
}

struct PermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionsView(coordinator: AppCoordinator())
            .frame(width: 395, height: 852)
            .clipShape(RoundedRectangle(cornerRadius: 48))
    }
}

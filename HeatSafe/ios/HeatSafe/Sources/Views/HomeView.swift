import SwiftUI

struct HomeView: View {
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                // Header (Greeting)
                VStack(alignment: .leading, spacing: 3) {
                    Text("Good morning, Arjun")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Theme.textSecondary)
                    
                    Text("Stay safe today")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Theme.textPrimary)
                        .tracking(-0.6)
                }
                .padding(.top, 16)
                
                // Heat Risk Gradient Card
                ZStack(alignment: .topLeading) {
                    // Orange to red custom gradient
                    Theme.heatRiskGradient
                    
                    // Soft circular ambient overlays
                    Circle()
                        .fill(Color.white.opacity(0.07))
                        .frame(width: 130, height: 130)
                        .position(x: 320, y: 10)
                    
                    Circle()
                        .fill(Color.white.opacity(0.04))
                        .frame(width: 100, height: 100)
                        .position(x: 280, y: 170)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        // High Risk Badge
                        HStack(spacing: 5) {
                            Image(systemName: "thermometer")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("HIGH RISK")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.white)
                                .tracking(0.6)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Capsule())
                        .padding(.bottom, 12)
                        
                        // 42°C display
                        HStack(alignment: .top, spacing: 0) {
                            Text("42")
                                .font(.system(size: 60, weight: .light, design: .default))
                                .foregroundColor(.white)
                                .tracking(-3)
                            Text("°C")
                                .font(.system(size: 26, weight: .light))
                                .foregroundColor(.white)
                                .padding(.top, 8)
                        }
                        .lineLimit(1)
                        .padding(.bottom, 6)
                        
                        // Labels
                        Text("Heat Warning Active")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.bottom, 2)
                        
                        Text("Jaipur, Rajasthan · Updated now")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.white.opacity(0.75))
                            .padding(.bottom, 12)
                        
                        // Humidity & Feels Like Meta details
                        HStack(spacing: 16) {
                            HStack(spacing: 5) {
                                Image(systemName: "humidity.fill")
                                    .font(.system(size: 11))
                                    .foregroundColor(.white.opacity(0.8))
                                Text("28% humidity")
                                    .font(.system(size: 12.5))
                                    .foregroundColor(.white.opacity(0.85))
                            }
                            
                            HStack(spacing: 5) {
                                Image(systemName: "wind")
                                    .font(.system(size: 11))
                                    .foregroundColor(.white.opacity(0.8))
                                Text("Feels like 47°C")
                                    .font(.system(size: 12.5))
                                    .foregroundColor(.white.opacity(0.85))
                            }
                        }
                    }
                    .padding(22)
                }
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .shadow(color: Color(hex: "F26B35").opacity(0.12), radius: 15, x: 0, y: 8)
                .padding(.top, 20)
                
                // Hydration Row
                HStack(alignment: .center, spacing: 18) {
                    // Left dial progress
                    ZStack {
                        Circle()
                            .stroke(Color(hex: "F0EBE5"), lineWidth: 7.5)
                            .frame(width: 78, height: 78)
                        
                        Circle()
                            .trim(from: 0, to: 0.5) // 50%
                            .stroke(
                                Theme.brandBlue,
                                style: StrokeStyle(lineWidth: 7.5, lineCap: .round)
                            )
                            .frame(width: 78, height: 78)
                            .rotationEffect(.degrees(-90))
                        
                        VStack(spacing: 0) {
                            Text("1.5")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Theme.textPrimary)
                            Text("litres")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(Theme.textSecondary)
                        }
                    }
                    .frame(width: 78, height: 78)
                    
                    // Right description and progress bar
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Hydration today")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Theme.textPrimary)
                        
                        Text("50% of 3L goal. Keep drinking to stay safe in this heat.")
                            .font(.system(size: 12.5))
                            .foregroundColor(Theme.textSecondary)
                            .lineSpacing(4)
                            .padding(.bottom, 10)
                        
                        // Progress bar capsule
                        GeometryReader { barGeo in
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(Color(hex: "F0EBE5"))
                                    .frame(height: 6)
                                
                                Capsule()
                                    .fill(Theme.hydrationProgressGradient)
                                    .frame(width: barGeo.size.width * 0.5, height: 6)
                            }
                        }
                        .frame(height: 6)
                    }
                }
                .padding(18)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 22))
                .overlay(
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(Color.black.opacity(0.07), lineWidth: 0.5)
                )
                .padding(.top, 16)
                
                // Section Title: Quick Actions
                Text("Quick actions")
                    .font(.system(size: 11.5, weight: .bold))
                    .foregroundColor(Theme.textSecondary)
                    .tracking(0.8)
                    .padding(.top, 18)
                    .padding(.bottom, 10)
                
                // Quick Actions (3 Grid Cards)
                HStack(spacing: 10) {
                    // Log Water -> triggers hydration tab
                    quickActionTile(
                        icon: "drop.bubble.fill",
                        backgroundColor: Color(hex: "EBF5FC"),
                        iconColor: Theme.brandBlue,
                        label: "Log Water",
                        action: {
                            withAnimation(.spring()) {
                                coordinator.setScreen("hydration")
                            }
                        }
                    )
                    
                    // Start Outdoor -> triggers stopwatch outdoor session tab
                    quickActionTile(
                        icon: "figure.walk",
                        backgroundColor: Color(hex: "FEF0EA"),
                        iconColor: Theme.brandOrange,
                        label: "Start Outdoor",
                        action: {
                            withAnimation(.spring()) {
                                coordinator.setScreen("session")
                            }
                        }
                    )
                    
                    // Symptoms -> triggers symptoms tab
                    quickActionTile(
                        icon: "heart.text.square.fill",
                        backgroundColor: Color(hex: "EBF6F0"),
                        iconColor: Theme.brandGreen,
                        label: "Symptoms",
                        action: {
                            withAnimation(.spring()) {
                                coordinator.setScreen("symptoms")
                            }
                        }
                    )
                }
                
                // Section Title: Wellness Tip
                Text("Wellness tip")
                    .font(.system(size: 11.5, weight: .bold))
                    .foregroundColor(Theme.textSecondary)
                    .tracking(0.8)
                    .padding(.top, 18)
                    .padding(.bottom, 10)
                
                // Tip Card
                HStack(alignment: .top, spacing: 12) {
                    // Tip Icon
                    Image(systemName: "lightbulb.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Theme.brandBlue)
                        .frame(width: 38, height: 38)
                        .background(Color(hex: "2E9CC8").opacity(0.18))
                        .clipShape(RoundedRectangle(cornerRadius: 11))
                    
                    // Tip Text
                    VStack(alignment: .leading, spacing: 3) {
                        Text("TODAY'S TIP")
                            .font(.system(size: 10.5, weight: .bold))
                            .foregroundColor(Theme.brandBlue)
                            .tracking(0.6)
                        
                        Text("Avoid outdoor activity between 11am – 4pm. Peak UV hours increase heat stress significantly.")
                            .font(.system(size: 12.5))
                            .foregroundColor(Color(hex: "2C5B72"))
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "EBF5FC"))
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color(hex: "2E9CC8").opacity(0.2), lineWidth: 0.5)
                )
                
                Color.clear
                    .frame(height: 120) // spacing to clear the tab bar completely
            }
            .padding(.horizontal, 20)
        }
    }
    
    // Quick Action button tile helper
    @ViewBuilder
    private func quickActionTile(icon: String, backgroundColor: Color, iconColor: Color, label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(iconColor)
                    .frame(width: 42, height: 42)
                    .background(backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                
                Text(label)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(Theme.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 8)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.black.opacity(0.07), lineWidth: 0.5)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(coordinator: AppCoordinator())
            .background(Theme.phoneBackground)
            .frame(width: 375, height: 812)
    }
}

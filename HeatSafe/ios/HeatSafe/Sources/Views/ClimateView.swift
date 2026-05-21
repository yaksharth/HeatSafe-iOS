import SwiftUI

struct ClimateView: View {
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        ZStack {
            // Background cream gradient
            Theme.cream
                .ignoresSafeArea()
            
            // Background Blur Blob
            ZStack {
                Circle()
                    .fill(Color(hex: "FF9E57").opacity(0.2))
                    .frame(width: 320, height: 320)
                    .blur(radius: 50)
                    .position(x: 380, y: 120)
            }
            .ignoresSafeArea()
            
            // Content
            VStack(alignment: .leading, spacing: 0) {
                // Sparkle Badge Icon
                HStack {
                    Image(systemName: "sparkles")
                        .font(.system(size: 26))
                        .foregroundColor(Color(hex: "A14E11"))
                        .frame(width: 64, height: 64)
                        .background(Color.white.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.white.opacity(0.4), lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                    
                    Spacer()
                }
                .padding(.top, 40)
                
                // Typography Section
                Text("Designed for\nwarmer days and\nsafer routines.")
                    .font(.system(size: 44, weight: .semibold, design: .default))
                    .lineSpacing(-2)
                    .tracking(-2.0)
                    .foregroundColor(Theme.textPrimary)
                    .minimumScaleFactor(0.85)
                    .padding(.top, 40)
                    .fixedSize(horizontal: false, vertical: true)
                
                // Today's Conditions glass card
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Today’s Conditions")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color(hex: "9B5E2A"))
                            
                            Text("41°")
                                .font(.system(size: 56, weight: .semibold, design: .rounded))
                                .foregroundColor(Color(hex: "A14E11"))
                                .tracking(-1.5)
                        }
                        
                        Spacer()
                        
                        // Sun Orb with custom gradient & inner shadow simulation
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color(hex: "FFD4A9"), Color(hex: "FFAB69")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 90, height: 90)
                            .shadow(color: Color(hex: "FF9E57").opacity(0.4), radius: 15, x: 0, y: 10)
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.35), lineWidth: 2)
                            )
                    }
                    
                    Text("Monitor outdoor exposure, hydration, and heat risk in one calm experience.")
                        .font(.system(size: 16, weight: .regular))
                        .lineSpacing(6)
                        .foregroundColor(Color(hex: "6E645B"))
                        .padding(.top, 24)
                }
                .padding(28)
                .glassCard(cornerRadius: 38)
                .padding(.top, 40)
                
                Spacer()
                
                // Navigation dots & Button
                VStack(alignment: .leading, spacing: 32) {
                    // Custom indicators
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color(hex: "DDD5CC"))
                            .frame(width: 8, height: 8)
                        
                        Capsule()
                            .fill(Theme.accentOrange)
                            .frame(width: 48, height: 8)
                        
                        Circle()
                            .fill(Color(hex: "DDD5CC"))
                            .frame(width: 8, height: 8)
                        
                        Circle()
                            .fill(Color(hex: "DDD5CC"))
                            .frame(width: 8, height: 8)
                    }
                    
                    // Button
                    Button(action: {
                        withAnimation(.spring(response: 0.45, dampingFraction: 0.75)) {
                            coordinator.next()
                        }
                    }) {
                        Text("Continue")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Theme.textPrimary)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .shadow(color: Color.black.opacity(0.12), radius: 20, x: 0, y: 15)
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 36)
        }
    }
}

struct ClimateView_Previews: PreviewProvider {
    static var previews: some View {
        ClimateView(coordinator: AppCoordinator())
            .frame(width: 395, height: 852)
            .clipShape(RoundedRectangle(cornerRadius: 48))
    }
}

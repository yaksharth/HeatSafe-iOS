import SwiftUI

struct HydrationIntroView: View {
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        ZStack {
            // Background cool gradient
            Theme.cool
                .ignoresSafeArea()
            
            // Background Blur Blob at bottom
            ZStack {
                Circle()
                    .fill(Color(hex: "8AC4FF").opacity(0.35))
                    .frame(width: 380, height: 380)
                    .blur(radius: 60)
                    .position(x: 197, y: 720)
            }
            .ignoresSafeArea()
            
            // Content
            VStack(alignment: .leading, spacing: 0) {
                // Drop Badge Icon
                HStack {
                    Image(systemName: "drop.fill")
                        .font(.system(size: 26))
                        .foregroundColor(Color(hex: "5DA5FF"))
                        .frame(width: 64, height: 64)
                        .background(Color.white.opacity(0.75))
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.white.opacity(0.4), lineWidth: 1)
                        )
                        .shadow(color: Color(hex: "DDEEFF").opacity(0.4), radius: 10, x: 0, y: 5)
                    
                    Spacer()
                }
                .padding(.top, 40)
                
                // Typography Section
                Text("Hydration that\nadapts to your\nenvironment.")
                    .font(.system(size: 44, weight: .semibold, design: .default))
                    .lineSpacing(-2)
                    .tracking(-2.0)
                    .foregroundColor(Theme.textPrimary)
                    .minimumScaleFactor(0.85)
                    .padding(.top, 40)
                    .fixedSize(horizontal: false, vertical: true)
                
                // Centered circular progress ring
                HStack {
                    Spacer()
                    ZStack {
                        // Background base ring
                        Circle()
                            .stroke(Color(hex: "DDEEFF"), lineWidth: 18)
                            .frame(width: 216, height: 216)
                        
                        // Active progress ring (trimmed, rotated to match React’s design)
                        Circle()
                            .trim(from: 0.0, to: 0.65)
                            .stroke(
                                LinearGradient(
                                    colors: [Color(hex: "5DA5FF"), Color(hex: "8AC4FF")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                style: StrokeStyle(lineWidth: 18, lineCap: .round)
                            )
                            .frame(width: 216, height: 216)
                            .rotationEffect(.degrees(-90))
                        
                        // Central texts
                        VStack(spacing: 4) {
                            Text("2.1L")
                                .font(.system(size: 56, weight: .semibold, design: .rounded))
                                .foregroundColor(Theme.textPrimary)
                                .tracking(-1.5)
                            
                            Text("Daily progress")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(Theme.textSecondary)
                        }
                    }
                    .frame(width: 256, height: 256)
                    .glassCard(cornerRadius: 128, strokeOpacity: 0.45, shadowRadius: 80)
                    .shadow(color: Color(hex: "4C97FF").opacity(0.12), radius: 40, x: 0, y: 30)
                    .padding(.top, 36)
                    Spacer()
                }
                
                Spacer()
                
                // Navigation dots & Button
                VStack(alignment: .leading, spacing: 32) {
                    // Custom indicators
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color(hex: "DDD5CC"))
                            .frame(width: 8, height: 8)
                        
                        Circle()
                            .fill(Color(hex: "DDD5CC"))
                            .frame(width: 8, height: 8)
                        
                        Capsule()
                            .fill(Theme.accentOrange)
                            .frame(width: 48, height: 8)
                        
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

struct HydrationIntroView_Previews: PreviewProvider {
    static var previews: some View {
        HydrationIntroView(coordinator: AppCoordinator())
            .frame(width: 395, height: 852)
            .clipShape(RoundedRectangle(cornerRadius: 48))
    }
}

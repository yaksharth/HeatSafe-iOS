import SwiftUI

struct OnboardingView: View {
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        ZStack {
            // Background warm gradient
            Theme.warm
                .ignoresSafeArea()
            
            // Background Blur Blobs
            ZStack {
                Circle()
                    .fill(Color(hex: "FFB56A").opacity(0.4))
                    .frame(width: 288, height: 288)
                    .blur(radius: 50)
                    .position(x: 350, y: -40)
                
                Circle()
                    .fill(Color(hex: "A9D3FF").opacity(0.3))
                    .frame(width: 256, height: 256)
                    .blur(radius: 50)
                    .position(x: -20, y: 600)
            }
            .ignoresSafeArea()
            
            // Content
            VStack(alignment: .leading, spacing: 0) {
                // Logo Icon Badge
                HStack {
                    Image(systemName: "sun.max.fill")
                        .font(.system(size: 30))
                        .foregroundColor(Theme.accentOrange)
                        .frame(width: 64, height: 64)
                        .background(Color.white.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.white.opacity(0.4), lineWidth: 1)
                        )
                        .shadow(color: Color(hex: "FFD4A9").opacity(0.4), radius: 10, x: 0, y: 8)
                    
                    Spacer()
                }
                .padding(.top, 40)
                
                // Typography Section
                VStack(alignment: .leading, spacing: 0) {
                    Text("HEATSAFE")
                        .font(.system(size: 12, weight: .semibold))
                        .tracking(3)
                        .foregroundColor(Theme.accentOrange)
                        .padding(.top, 60)
                    
                    Text("Extreme heat\nis becoming\npart of\neveryday life.")
                        .font(.system(size: 46, weight: .semibold, design: .default))
                        .lineSpacing(-2)
                        .tracking(-2.2)
                        .foregroundColor(Theme.textPrimary)
                        .minimumScaleFactor(0.85)
                        .padding(.top, 24)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("A calmer way to stay hydrated, aware, and safer outdoors.")
                        .font(.system(size: 18, weight: .regular))
                        .lineSpacing(6)
                        .foregroundColor(Theme.textSecondary)
                        .frame(maxWidth: 280, alignment: .leading)
                        .padding(.top, 28)
                }
                
                Spacer()
                
                // Navigation dots & Button
                VStack(alignment: .leading, spacing: 32) {
                    // Custom indicators
                    HStack(spacing: 8) {
                        Capsule()
                            .fill(Theme.accentOrange)
                            .frame(width: 48, height: 8)
                        
                        Circle()
                            .fill(Color(hex: "DDD5CC"))
                            .frame(width: 8, height: 8)
                        
                        Circle()
                            .fill(Color(hex: "DDD5CC"))
                            .frame(width: 8, height: 8)
                        
                        Circle()
                            .fill(Color(hex: "DDD5CC"))
                            .frame(width: 8, height: 8)
                    }
                    
                    // Main action button
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
                            .shadow(color: Color.black.opacity(0.15), radius: 25, x: 0, y: 20)
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 36)
        }
    }
}

// Visual feedback on button press
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(coordinator: AppCoordinator())
            .frame(width: 395, height: 852)
            .clipShape(RoundedRectangle(cornerRadius: 48))
    }
}

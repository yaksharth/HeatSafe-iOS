import SwiftUI
import Combine

struct SessionView: View {
    @ObservedObject var coordinator: AppCoordinator
    
    // Stopwatch states
    @State private var secondsElapsed: Int = 24 * 60 + 38 // Starts at 24:38 (1478 seconds)
    @State private var isRunning: Bool = true
    @State private var stopwatchTimer: AnyCancellable? = nil
    
    // Interactive Logged water state (starts at 250ml as in mock)
    @State private var loggedWaterMl: Int = 250
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                // Header Titles
                VStack(alignment: .leading, spacing: 4) {
                    Text("Outdoor session")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Theme.textPrimary)
                        .tracking(-0.5)
                    
                    Text("Stay aware · Stay safe")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(Theme.textSecondary)
                }
                .padding(.top, 16)
                
                // Session Hero (Slate Blue Gradient)
                VStack(spacing: 0) {
                    // Active Status Badge
                    HStack(spacing: 6) {
                        Circle()
                            .fill(Color(hex: "4CAF84"))
                            .frame(width: 7, height: 7)
                            .opacity(isRunning ? 1.0 : 0.4)
                            .scaleEffect(isRunning ? 1.2 : 1.0)
                            .animation(isRunning ? .easeInOut(duration: 1.0).repeatForever(autoreverses: true) : .default, value: isRunning)
                        
                        Text(isRunning ? "Active session" : "Session Paused")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white.opacity(0.8))
                            .tracking(0.9)
                            .textCase(.uppercase)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 5)
                    .background(Color.white.opacity(0.1))
                    .clipShape(Capsule())
                    .padding(.top, 24)
                    .padding(.bottom, 18)
                    
                    // Stopwatch Timer
                    Text(formatSeconds(secondsElapsed))
                        .font(.system(size: 58, weight: .light, design: .rounded))
                        .foregroundColor(.white)
                        .tracking(-3)
                        .padding(.bottom, 5)
                    
                    Text("minutes elapsed")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white.opacity(0.45))
                        .padding(.bottom, 20)
                    
                    // Session Stats Grid (Ambient, Logged, Risk)
                    HStack(spacing: 0) {
                        // Ambient
                        VStack(spacing: 3) {
                            Text("42°C")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundColor(.white)
                            Text("Ambient")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white.opacity(0.45))
                                .tracking(0.6)
                                .textCase(.uppercase)
                        }
                        .frame(maxWidth: .infinity)
                        
                        // Logged Water (Dynamic State!)
                        VStack(spacing: 3) {
                            Text("\(loggedWaterMl)ml")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundColor(.white)
                            Text("Logged")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white.opacity(0.45))
                                .tracking(0.6)
                                .textCase(.uppercase)
                        }
                        .frame(maxWidth: .infinity)
                        
                        // Risk
                        VStack(spacing: 3) {
                            Text("High")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundColor(.white)
                            Text("Risk")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white.opacity(0.45))
                                .tracking(0.6)
                                .textCase(.uppercase)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.bottom, 24)
                }
                .frame(maxWidth: .infinity)
                .background(Theme.sessionHeroGradient)
                .clipShape(RoundedRectangle(cornerRadius: 26))
                .padding(.top, 14)
                
                // Session Controls (Pause, Stop)
                HStack(spacing: 10) {
                    // Play/Pause Action Button
                    Button(action: {
                        isRunning.toggle()
                        if isRunning {
                            startTimer()
                        } else {
                            stopTimer()
                        }
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: isRunning ? "pause.fill" : "play.fill")
                                .font(.system(size: 16, weight: .bold))
                            Text(isRunning ? "Pause session" : "Resume session")
                                .font(.system(size: 15, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Theme.brandBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                    }
                    .buttonStyle(ScaleButtonStyle())
                    
                    // Stop / Reset Button (Square)
                    Button(action: {
                        // Resets to Home screen safely
                        secondsElapsed = 0
                        isRunning = false
                        stopTimer()
                        withAnimation(.spring()) {
                            coordinator.setScreen("home")
                        }
                    }) {
                        Image(systemName: "square.fill")
                            .font(.system(size: 18))
                            .foregroundColor(Color(hex: "7A6D64"))
                            .frame(width: 54, height: 54)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.black.opacity(0.09), lineWidth: 0.5)
                            )
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
                .padding(.top, 14)
                
                // Hydration Reminder (Blue glass card)
                HStack(alignment: .center, spacing: 13) {
                    Image(systemName: "drop.fill")
                        .font(.system(size: 18))
                        .foregroundColor(Theme.brandBlue)
                        .frame(width: 38, height: 38)
                        .background(Color(hex: "2E9CC8").opacity(0.18))
                        .clipShape(RoundedRectangle(cornerRadius: 11))
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Time to hydrate")
                            .font(.system(size: 13.5, weight: .bold))
                            .foregroundColor(Color(hex: "1A4D66"))
                        
                        Text("15 min since last break. Drink 200–300 ml now.")
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "4A7A92"))
                            .lineSpacing(3)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    Spacer()
                    
                    // Log water button increments the logged state!
                    Button(action: {
                        withAnimation(.spring()) {
                            loggedWaterMl += 250
                        }
                    }) {
                        Text("Log")
                            .font(.system(size: 12.5, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Theme.brandBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 11))
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
                .padding(16)
                .background(Color(hex: "EBF5FC"))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(hex: "2E9CC8").opacity(0.18), lineWidth: 0.5)
                )
                .padding(.top, 14)
                
                // Warn Card: Peak Heat Window (Orange)
                warnRow(
                    icon: "exclamationmark.triangle.fill",
                    iconColor: Theme.brandOrange,
                    bgColor: Color(hex: "FEF5EE"),
                    borderColor: Color(hex: "E8703A").opacity(0.2),
                    title: "Peak heat window",
                    description: "24 min in peak hours. Consider moving to shade soon.",
                    titleColor: Color(hex: "7A3B12"),
                    descColor: Color(hex: "9B5A33")
                )
                .padding(.top, 10)
                
                // Warn Card: Session Goal (Green)
                warnRow(
                    icon: "clock.fill",
                    iconColor: Theme.brandGreen,
                    bgColor: Color(hex: "EBF6F0"),
                    borderColor: Color(hex: "2DA676").opacity(0.2),
                    title: "Session goal",
                    description: "Recommended limit: 30 min. About 6 min remaining safely.",
                    titleColor: Color(hex: "1A5C38"),
                    descColor: Color(hex: "2D6647")
                )
                .padding(.top, 10)
                
                Color.clear
                    .frame(height: 120)
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            if isRunning {
                startTimer()
            }
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    // Warning Row Helper
    @ViewBuilder
    private func warnRow(icon: String, iconColor: Color, bgColor: Color, borderColor: Color, title: String, description: String, titleColor: Color, descColor: Color) -> some View {
        HStack(alignment: .top, spacing: 11) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(iconColor)
                .padding(.top, 1)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(titleColor)
                
                Text(description)
                    .font(.system(size: 12))
                    .foregroundColor(descColor)
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(bgColor)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(borderColor, lineWidth: 0.5)
        )
    }
    
    // Clock formatter helper
    private func formatSeconds(_ totalSecs: Int) -> String {
        let mins = totalSecs / 60
        let secs = totalSecs % 60
        return String(format: "%02d:%02d", mins, secs)
    }
    
    private func startTimer() {
        stopTimer()
        stopwatchTimer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                secondsElapsed += 1
            }
    }
    
    private func stopTimer() {
        stopwatchTimer?.cancel()
        stopwatchTimer = nil
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView(coordinator: AppCoordinator())
            .background(Theme.phoneBackground)
            .frame(width: 375, height: 812)
    }
}

import SwiftUI

struct HydrationView: View {
    @ObservedObject var coordinator: AppCoordinator
    
    // Intake log items matching the mockup
    private let intakeLog: [(title: String, time: String, amount: String)] = [
        ("Morning water", "7:15 am", "500 ml"),
        ("Bottle", "8:40 am", "500 ml"),
        ("Tea", "9:10 am", "150 ml"),
        ("Water glass", "9:30 am", "350 ml")
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                // Header Titles
                VStack(alignment: .leading, spacing: 4) {
                    Text("Hydration")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Theme.textPrimary)
                        .tracking(-0.5)
                    
                    Text("Thursday, 21 May 2026")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(Theme.textSecondary)
                }
                .padding(.top, 16)
                
                // Hydration Hero Circle Progress
                HStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(Color(hex: "F0EBE5"), lineWidth: 11)
                            .frame(width: 150, height: 150)
                        
                        Circle()
                            .trim(from: 0, to: 0.5) // 50% progress
                            .stroke(
                                Theme.brandBlue,
                                style: StrokeStyle(lineWidth: 11, lineCap: .round)
                            )
                            .frame(width: 150, height: 150)
                            .rotationEffect(.degrees(-90))
                        
                        VStack(spacing: 2) {
                            Text("1.5L")
                                .font(.system(size: 36, weight: .light, design: .rounded))
                                .foregroundColor(Theme.textPrimary)
                                .tracking(-1)
                                .lineLimit(1)
                            
                            Text("consumed")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(Theme.textSecondary)
                            
                            Text("of 3.0L goal")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color(hex: "C0B5AD"))
                        }
                    }
                    .frame(width: 150, height: 150)
                    .padding(.vertical, 18)
                    Spacer()
                }
                
                // Add Water Card
                VStack(alignment: .leading, spacing: 13) {
                    Text("Add water intake")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Theme.textPrimary)
                    
                    // Buttons 2x2 Grid
                    VStack(spacing: 9) {
                        HStack(spacing: 9) {
                            waterIntakeButton(icon: "cup.and.saucer.fill", title: "+ 250 ml", desc: "Small glass")
                            waterIntakeButton(icon: "mug.fill", title: "+ 500 ml", desc: "Bottle")
                        }
                        
                        HStack(spacing: 9) {
                            waterIntakeButton(icon: "drop.triangle.fill", title: "+ 150 ml", desc: "Cup / tea")
                            waterIntakeButton(icon: "plus", title: "Custom", desc: "Enter amount")
                        }
                    }
                }
                .padding(18)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 22))
                .overlay(
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(Color.black.opacity(0.07), lineWidth: 0.5)
                )
                
                // Intake Log
                VStack(alignment: .leading, spacing: 0) {
                    // Log Header
                    HStack {
                        Text("Today's log")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Theme.textPrimary)
                        
                        Spacer()
                        
                        Text("4 entries · 1,500 ml")
                            .font(.system(size: 11.5, weight: .bold))
                            .foregroundColor(Theme.textSecondary)
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 14)
                    .background(Color.white)
                    
                    Divider()
                        .background(Color.black.opacity(0.06))
                    
                    // Log List items
                    VStack(spacing: 0) {
                        ForEach(intakeLog.indices, id: \.self) { index in
                            HStack(alignment: .center, spacing: 13) {
                                Circle()
                                    .fill(Theme.brandBlue)
                                    .frame(width: 8, height: 8)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(intakeLog[index].title)
                                        .font(.system(size: 13.5, weight: .semibold))
                                        .foregroundColor(Theme.textPrimary)
                                    
                                    Text(intakeLog[index].time)
                                        .font(.system(size: 11, weight: .regular))
                                        .foregroundColor(Theme.textSecondary)
                                }
                                
                                Spacer()
                                
                                Text(intakeLog[index].amount)
                                    .font(.system(size: 13.5, weight: .bold))
                                    .foregroundColor(Theme.brandBlue)
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 12)
                            
                            // Divider for all but the last item
                            if index < intakeLog.count - 1 {
                                Divider()
                                    .background(Color.black.opacity(0.04))
                                    .padding(.leading, 18)
                            }
                        }
                    }
                    .background(Color.white)
                }
                .clipShape(RoundedRectangle(cornerRadius: 22))
                .overlay(
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(Color.black.opacity(0.07), lineWidth: 0.5)
                )
                .padding(.top, 14)
                
                Color.clear
                    .frame(height: 120)
            }
            .padding(.horizontal, 20)
        }
    }
    
    // Intake Button Cell Helper
    @ViewBuilder
    private func waterIntakeButton(icon: String, title: String, desc: String) -> some View {
        Button(action: {
            print("Logged water: \(title)")
        }) {
            VStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundColor(Theme.brandBlue)
                
                Text(title)
                    .font(.system(size: 12.5, weight: .bold))
                    .foregroundColor(Theme.brandBlue)
                
                Text(desc)
                    .font(.system(size: 10.5, weight: .semibold))
                    .foregroundColor(Color(hex: "7AAFC4"))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 10)
            .background(Color(hex: "F0F7FC"))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color(hex: "2E9CC8").opacity(0.2), lineWidth: 0.5)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct HydrationView_Previews: PreviewProvider {
    static var previews: some View {
        HydrationView(coordinator: AppCoordinator())
            .background(Theme.phoneBackground)
            .frame(width: 375, height: 812)
    }
}

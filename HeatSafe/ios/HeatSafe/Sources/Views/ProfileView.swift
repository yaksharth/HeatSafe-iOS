import SwiftUI

struct ProfileView: View {
    @ObservedObject var coordinator: AppCoordinator
    
    // Weekly data values
    private let weeklyData: [(day: String, value: CGFloat)] = [
        ("M", 0.90),
        ("T", 0.75),
        ("W", 0.80),
        ("T", 0.95),
        ("F", 0.85),
        ("S", 0.90),
        ("S", 1.00)
    ]
    
    @State private var animateBars: Bool = false
    
    var body: some View {
        ZStack {
            // Background Blur Blob (top-right light blue)
            ZStack {
                Circle()
                    .fill(Color(hex: "A8D4FF").opacity(0.35))
                    .frame(width: 320, height: 320)
                    .blur(radius: 50)
                    .position(x: 350, y: 100)
            }
            .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your Wellness")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(Theme.textPrimary)
                            .tracking(-1.5)
                        
                        Text("A personal overview of hydration and outdoor wellness patterns.")
                            .font(.system(size: 17, weight: .regular))
                            .lineSpacing(6)
                            .foregroundColor(Color(hex: "71685F"))
                            .frame(maxWidth: 300, alignment: .leading)
                    }
                    .padding(.top, 24)
                    
                    // Weekly Hydration Glass Card
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Weekly Hydration")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color(hex: "84796F"))
                        
                        Text("89%")
                            .font(.system(size: 52, weight: .bold, design: .rounded))
                            .foregroundColor(Theme.textPrimary)
                            .tracking(-1.2)
                            .padding(.top, 4)
                        
                        // Custom Weekly Bar Chart
                        HStack(alignment: .bottom, spacing: 16) {
                            ForEach(weeklyData.indices, id: \.self) { index in
                                VStack(spacing: 8) {
                                    // Custom Bar
                                    GeometryReader { barGeo in
                                        ZStack(alignment: .bottom) {
                                            // Bar Track
                                            Capsule()
                                                .fill(Color(hex: "DDEEFF").opacity(0.5))
                                            
                                            // Bar Filled
                                            Capsule()
                                                .fill(
                                                    LinearGradient(
                                                        colors: [Color(hex: "5DA5FF"), Color(hex: "A9D3FF")],
                                                        startPoint: .top,
                                                        endPoint: .bottom
                                                    )
                                                )
                                                .frame(height: barGeo.size.height * (animateBars ? weeklyData[index].value : 0.0))
                                                .animation(
                                                    .spring(response: 0.6, dampingFraction: 0.7)
                                                    .delay(Double(index) * 0.05),
                                                    value: animateBars
                                                )
                                        }
                                    }
                                    .frame(height: 128)
                                    
                                    // Day Label
                                    Text(weeklyData[index].day)
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(Color(hex: "84796F"))
                                }
                            }
                        }
                        .padding(.top, 24)
                    }
                    .padding(32)
                    .glassCard(cornerRadius: 40)
                    .shadow(color: Color.black.opacity(0.04), radius: 40, x: 0, y: 20)
                    .padding(.top, 40)
                    
                    // Extra aesthetic details: Wellness summary items
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Outdoor Safety Stats")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Theme.textPrimary)
                            .padding(.top, 40)
                        
                        // Double Row Grid Items
                        HStack(spacing: 16) {
                            statsTile(title: "Active Outdoors", value: "5.4 hrs", desc: "Weekly total")
                            statsTile(title: "Peak UV Exposure", value: "Low", desc: "Stayed protected")
                        }
                    }
                    
                    Color.clear
                        .frame(height: 140)
                }
                .padding(.horizontal, 28)
            }
        }
        .onAppear {
            // Trigger weekly bar growth animation
            animateBars = true
        }
    }
    
    @ViewBuilder
    private func statsTile(title: String, value: String, desc: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Theme.textSecondary)
            
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Theme.textPrimary)
                .padding(.top, 2)
            
            Text(desc)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(Theme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .glassCard(cornerRadius: 28)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(coordinator: AppCoordinator())
            .background(Theme.cream)
            .frame(width: 395, height: 852)
    }
}

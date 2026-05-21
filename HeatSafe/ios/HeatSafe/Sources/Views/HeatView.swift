import SwiftUI

struct HeatView: View {
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                // Header with Back Button
                HStack(spacing: 12) {
                    Button(action: {
                        withAnimation(.spring()) {
                            coordinator.setScreen("home")
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Theme.textPrimary)
                            .frame(width: 36, height: 36)
                            .background(Color.black.opacity(0.06))
                            .clipShape(Circle())
                    }
                    .buttonStyle(ScaleButtonStyle())
                    
                    Text("Heat Risk Details")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Theme.textPrimary)
                        .tracking(-0.4)
                }
                .padding(.top, 16)
                
                // Risk Visual Card
                VStack(alignment: .leading, spacing: 10) {
                    Text("Today's heat level")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Theme.textSecondary)
                    
                    // Segmented Scale Bar
                    HStack(spacing: 3) {
                        // Low Segment
                        Capsule()
                            .fill(Color(hex: "4CAF84"))
                            .frame(height: 9)
                        
                        // Moderate Segment
                        Capsule()
                            .fill(Color(hex: "F5C842"))
                            .frame(height: 9)
                        
                        // High Segment (Highlighted with double thick border)
                        Capsule()
                            .fill(Color(hex: "F28040"))
                            .frame(height: 9)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4.5)
                                    .stroke(Color(hex: "F28040"), lineWidth: 2)
                                    .padding(-2)
                            )
                        
                        // Extreme Segment
                        Capsule()
                            .fill(Color(hex: "E8483A"))
                            .frame(height: 9)
                    }
                    .padding(.vertical, 4)
                    
                    // Scale Labels
                    HStack {
                        Text("Low").font(.system(size: 9.5, weight: .bold))
                        Spacer()
                        Text("Moderate").font(.system(size: 9.5, weight: .bold))
                        Spacer()
                        Text("High").font(.system(size: 9.5, weight: .bold))
                        Spacer()
                        Text("Extreme").font(.system(size: 9.5, weight: .bold))
                    }
                    .foregroundColor(Theme.textSecondary)
                    .padding(.bottom, 6)
                    
                    // Precaution tag
                    HStack(spacing: 7) {
                        Circle()
                            .fill(Theme.brandOrange)
                            .frame(width: 8, height: 8)
                        
                        Text("High — take precautions now")
                            .font(.system(size: 12.5, weight: .bold))
                            .foregroundColor(Color(hex: "C4531F"))
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(Color(hex: "FEF0EA"))
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(Color(hex: "E8703A").opacity(0.25), lineWidth: 0.5)
                    )
                }
                .padding(20)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 22))
                .overlay(
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(Color.black.opacity(0.07), lineWidth: 0.5)
                )
                .padding(.top, 20)
                
                // Weather Grid (2x2 Grid)
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        weatherGridCell(label: "Temperature", value: "42", unit: "°C")
                        weatherGridCell(label: "Feels like", value: "47", unit: "°C")
                    }
                    
                    HStack(spacing: 10) {
                        weatherGridCell(label: "Humidity", value: "28", unit: "%")
                        weatherGridCell(label: "UV Index", value: "9", unit: " very high")
                    }
                }
                .padding(.top, 14)
                
                // Section: Safety Guidance
                Text("Safety guidance")
                    .font(.system(size: 11.5, weight: .bold))
                    .foregroundColor(Theme.textSecondary)
                    .tracking(0.8)
                    .padding(.top, 18)
                    .padding(.bottom, 10)
                
                // Guidance Rows
                VStack(spacing: 10) {
                    guidanceRow(
                        icon: "clock.fill",
                        iconBg: Color(hex: "FEF0EA"),
                        iconColor: Theme.brandOrange,
                        title: "Limit outdoor time",
                        description: "Stay indoors between 11am and 4pm. Avoid strenuous activity."
                    )
                    
                    guidanceRow(
                        icon: "drop.fill",
                        iconBg: Color(hex: "EBF5FC"),
                        iconColor: Theme.brandBlue,
                        title: "Hydrate actively",
                        description: "Drink at least 3–4 litres today. Add electrolytes if outdoors."
                    )
                    
                    guidanceRow(
                        icon: "tag.fill",
                        iconBg: Color(hex: "EBF6F0"),
                        iconColor: Theme.brandGreen,
                        title: "Wear light clothing",
                        description: "Loose, breathable fabrics in light colours. Cover your head."
                    )
                    
                    guidanceRow(
                        icon: "house.fill",
                        iconBg: Color(hex: "FEF0EA"),
                        iconColor: Theme.brandOrange,
                        title: "Stay in cool spaces",
                        description: "Air-conditioned areas reduce your heat exposure significantly."
                    )
                }
                
                Color.clear
                    .frame(height: 120)
            }
            .padding(.horizontal, 20)
        }
    }
    
    // Grid Cell Helper
    @ViewBuilder
    private func weatherGridCell(label: String, value: String, unit: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.system(size: 10.5, weight: .bold))
                .foregroundColor(Theme.textSecondary)
                .tracking(0.5)
            
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text(value)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Theme.textPrimary)
                    .tracking(-0.5)
                
                Text(unit)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Theme.textSecondary)
                    .padding(.leading, 2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color(hex: "F8F5F1"))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    // Guidance Row Helper
    @ViewBuilder
    private func guidanceRow(icon: String, iconBg: Color, iconColor: Color, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 13) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(iconColor)
                .frame(width: 38, height: 38)
                .background(iconBg)
                .clipShape(RoundedRectangle(cornerRadius: 11))
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Theme.textPrimary)
                
                Text(description)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color(hex: "7A6D64"))
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.black.opacity(0.07), lineWidth: 0.5)
        )
    }
}

struct HeatView_Previews: PreviewProvider {
    static var previews: some View {
        HeatView(coordinator: AppCoordinator())
            .background(Theme.phoneBackground)
            .frame(width: 375, height: 812)
    }
}

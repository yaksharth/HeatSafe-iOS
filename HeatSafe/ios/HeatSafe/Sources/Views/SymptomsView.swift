import SwiftUI

struct SymptomsView: View {
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                // Header Titles
                VStack(alignment: .leading, spacing: 4) {
                    Text("Symptoms guide")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Theme.textPrimary)
                        .tracking(-0.5)
                    
                    Text("Know the signs, act early")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(Theme.textSecondary)
                }
                .padding(.top, 16)
                
                // Emergency SOS Banner (Red Gradient)
                HStack(alignment: .center, spacing: 13) {
                    // Warning icon container
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(width: 42, height: 42)
                        .background(Color.white.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Emergency: Call 112")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("If someone loses consciousness or stops sweating in extreme heat.")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.8))
                            .lineSpacing(4)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(
                        colors: [Color(hex: "E8483A"), Color(hex: "CC2F27")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.top, 14)
                
                // Symptom Cards Stack
                VStack(spacing: 10) {
                    // Heat Cramps Card
                    symptomDetailCard(
                        severityColor: Color(hex: "F5C842"),
                        title: "Heat cramps",
                        severityLabel: "Moderate",
                        severityTextColor: Color(hex: "997A00"),
                        severityBg: Color(hex: "FEF9E5"),
                        chips: ["Muscle pain", "Muscle spasms", "Heavy sweating"]
                    )
                    
                    // Heat Exhaustion Card
                    symptomDetailCard(
                        severityColor: Color(hex: "F28040"),
                        title: "Heat exhaustion",
                        severityLabel: "Serious",
                        severityTextColor: Color(hex: "C4531F"),
                        severityBg: Color(hex: "FEF0EA"),
                        chips: ["Dizziness", "Nausea", "Pale skin", "Weakness"]
                    )
                    
                    // Heat Stroke Card
                    symptomDetailCard(
                        severityColor: Color(hex: "E8483A"),
                        title: "Heat stroke",
                        severityLabel: "Critical",
                        severityTextColor: Color(hex: "A32D2D"),
                        severityBg: Color(hex: "FDEEEE"),
                        chips: ["High temp 40°C+", "Confusion", "No sweating", "Unconscious"]
                    )
                }
                .padding(.top, 14)
                
                // Prevention Steps (Green Card)
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 7) {
                        Image(systemName: "shield.fill")
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: "1A6644"))
                        
                        Text("Prevention steps")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color(hex: "1A6644"))
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        preventionRow(text: "Drink water before you feel thirsty")
                        preventionRow(text: "Rest in shade every 30 minutes outdoors")
                        preventionRow(text: "Never leave children in parked vehicles")
                        preventionRow(text: "Check on elderly neighbours during heat waves")
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex: "EBF6F0"))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(hex: "2DA676").opacity(0.2), lineWidth: 0.5)
                )
                .padding(.top, 14)
                
                Color.clear
                    .frame(height: 120)
            }
            .padding(.horizontal, 20)
        }
    }
    
    // Symptom Card Helper
    @ViewBuilder
    private func symptomDetailCard(severityColor: Color, title: String, severityLabel: String, severityTextColor: Color, severityBg: Color, chips: [String]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header Row
            HStack(spacing: 10) {
                Circle()
                    .fill(severityColor)
                    .frame(width: 10, height: 10)
                
                Text(title)
                    .font(.system(size: 14.5, weight: .bold))
                    .foregroundColor(Theme.textPrimary)
                
                Spacer()
                
                Text(severityLabel)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(severityTextColor)
                    .tracking(0.4)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(severityBg)
                    .clipShape(Capsule())
            }
            
            // Chips (Flex Wrap layout simulation for clean SwiftUI grids)
            HStack(spacing: 6) {
                ForEach(chips, id: \.self) { chip in
                    Text(chip)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(hex: "5A4D44"))
                        .padding(.horizontal, 11)
                        .padding(.vertical, 5)
                        .background(Color(hex: "F3EFE9"))
                        .clipShape(Capsule())
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black.opacity(0.07), lineWidth: 0.5)
        )
    }
    
    // Prevention Checklist Row Helper
    @ViewBuilder
    private func preventionRow(text: String) -> some View {
        HStack(alignment: .top, spacing: 9) {
            ZStack {
                Circle()
                    .fill(Color(hex: "2DA676").opacity(0.22))
                    .frame(width: 18, height: 18)
                
                Image(systemName: "checkmark")
                    .font(.system(size: 9, weight: .bold))
                    .foregroundColor(Color(hex: "2DA676"))
            }
            .padding(.top, 1)
            
            Text(text)
                .font(.system(size: 12.5, weight: .medium))
                .foregroundColor(Color(hex: "2C5B42"))
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct SymptomsView_Previews: PreviewProvider {
    static var previews: some View {
        SymptomsView(coordinator: AppCoordinator())
            .background(Theme.phoneBackground)
            .frame(width: 375, height: 812)
    }
}

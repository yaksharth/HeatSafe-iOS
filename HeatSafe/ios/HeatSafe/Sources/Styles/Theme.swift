import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

// --- Color Hex Extension ---
extension Color {
    public init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 255, 255, 255)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// --- Visual Effect Blur View for UIKit Backdrop Blurs ---
public struct VisualEffectBlur: UIViewRepresentable {
    public var blurStyle: UIBlurEffect.Style
    
    public init(blurStyle: UIBlurEffect.Style = .systemUltraThinMaterial) {
        self.blurStyle = blurStyle
    }
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        return view
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: blurStyle)
    }
}

// --- Premium HeatSafe Layout Gradients & Styles ---
public struct Theme {
    // New Mockup Specific Theme Colors
    public static let textPrimary = Color(hex: "2C1F17")
    public static let textSecondary = Color(hex: "9B8C82")
    public static let textLight = Color(hex: "FBF8F4")
    
    // Core brand accents
    public static let brandOrange = Color(hex: "E8703A")
    public static let brandBlue = Color(hex: "2E9CC8")
    public static let brandGreen = Color(hex: "2DA676")
    public static let brandRed = Color(hex: "E8483A")
    
    // Background tones
    public static let phoneBackground = Color(hex: "FBF8F4")
    public static let desktopBackground = Color(hex: "F0EDE8")
    
    // Onboarding gradients (retained for high quality sequence)
    public static let warm = LinearGradient(
        colors: [Color(hex: "FFB97D"), Color(hex: "FFCF9F"), Color(hex: "FFF6EE")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    public static let cool = LinearGradient(
        colors: [Color(hex: "A9D3FF"), Color(hex: "D9ECFF"), Color(hex: "F7FBFF")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    public static let cream = LinearGradient(
        colors: [Color(hex: "FFF6EE"), Color(hex: "FFF9F4"), Color(hex: "F7F3EE")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // Production Mockup Gradients
    public static let heatRiskGradient = LinearGradient(
        colors: [Color(hex: "FF8C5A"), Color(hex: "F26B35"), Color(hex: "E05520")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    public static let sessionHeroGradient = LinearGradient(
        colors: [Color(hex: "2E3D52"), Color(hex: "1A2A40")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    public static let hydrationProgressGradient = LinearGradient(
        colors: [Color(hex: "4AACDE"), Color(hex: "2A8CBE")],
        startPoint: .leading,
        endPoint: .trailing
    )
}

// --- Custom Glassmorphic Modifier ---
public struct GlassCardModifier: ViewModifier {
    var cornerRadius: CGFloat
    var strokeOpacity: Double
    var shadowRadius: CGFloat
    
    public func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white.opacity(0.85)) // High opacity for clean contrast
            )
            .background(
                VisualEffectBlur(blurStyle: .systemUltraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        Color.white.opacity(strokeOpacity),
                        lineWidth: 0.8
                    )
            )
            .shadow(
                color: Color.black.opacity(0.04),
                radius: shadowRadius,
                x: 0,
                y: 10
            )
    }
}

extension View {
    public func glassCard(cornerRadius: CGFloat = 20, strokeOpacity: Double = 0.4, shadowRadius: CGFloat = 20) -> some View {
        self.modifier(GlassCardModifier(cornerRadius: cornerRadius, strokeOpacity: strokeOpacity, shadowRadius: shadowRadius))
    }
}

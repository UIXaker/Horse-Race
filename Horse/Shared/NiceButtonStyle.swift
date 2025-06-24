import SwiftUI

struct NiceButtonStyle: ButtonStyle {
    var color: Color
    var strokeWidth: CGFloat = 0
    var strokeColor: Color = .clear
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .semibold))
            .padding(.top, configuration.isPressed ? 14 : 13)
            .padding(.bottom, configuration.isPressed ? 13 : 14)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: configuration.isPressed ? 16 : 14)
                    .fill(color)
                    .stroke(strokeColor, lineWidth: strokeWidth)
            )
            .overlay(
                configuration.isPressed ? Color.black.opacity(0.15) : Color.clear
            )
            .clipShape(RoundedRectangle(cornerRadius: configuration.isPressed ? 16 : 14))
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .shadow(color: configuration.isPressed ? Color.black.opacity(0.1) : Color.clear,
                    radius: configuration.isPressed ? 10 : 0,
                    x: configuration.isPressed ? 0 : 0,
                    y: configuration.isPressed ? -3 : 0)
            .animation(.spring().speed(1.5), value: configuration.isPressed)
    }
}

import SwiftUI

public struct DefaultThumb: View {
    public var body: some View {
        Circle()
            .foregroundColor(.white)
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1.5)
    }
}

#if DEBUG
struct DefaultThumb_Previews: PreviewProvider {
    static var previews: some View {
        DefaultThumb()
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
#endif

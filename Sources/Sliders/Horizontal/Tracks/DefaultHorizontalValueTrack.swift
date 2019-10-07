import SwiftUI

public struct DefaultHorizontalValueTrack<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let value: V
    
    public var body: some View {
        HTrack(
            value: value,
            valueView: Rectangle()
                .foregroundColor(.accentColor)
                .frame(height: 3),
            maskView: Rectangle(),
            leadingOffset: 13.5,
            trailingOffset: 13.5
        )
        .frame(height: 3)
        .background(Color.secondary.opacity(0.25))
        .cornerRadius(1.5)
    }
}

#if DEBUG
struct DefaultHorizontalValueTrack_Previews: PreviewProvider {
    
    static var previews: some View {
        DefaultHorizontalValueTrack(value: 0.5)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
#endif

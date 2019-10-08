import SwiftUI

public struct DefaultVerticalValueTrack<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let value: V
    
    public var body: some View {
        VTrack(
            value: value,
            valueView: Rectangle()
                .foregroundColor(.accentColor)
                .frame(width: 3),
            maskView: Rectangle(),
            leadingOffset: 13.5,
            trailingOffset: 13.5
        )
        .frame(width: 3)
        .background(Color.secondary.opacity(0.25))
        .cornerRadius(1.5)
    }
}

#if DEBUG
struct DefaultVerticalValueTrack_Previews: PreviewProvider {
    
    static var previews: some View {
        DefaultVerticalValueTrack(value: 0.5)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
#endif

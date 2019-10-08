import SwiftUI

public struct DefaultVerticalRangeTrack<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let range: ClosedRange<V>
    
    public var body: some View {
        VRangeTrack(
            range: range,
            valueView: Rectangle()
                .foregroundColor(.accentColor)
                .frame(width: 3),
            maskView: Rectangle(),
            lowerLeadingOffset: 13.5,
            lowerTrailingOffset: 13.5,
            upperLeadingOffset: 13.5,
            upperTrailingOffset: 13.5
        )
        .frame(width: 3)
        .background(Color.secondary.opacity(0.25))
        .cornerRadius(1.5)
    }
}

#if DEBUG
struct DefaultVerticalRangeTrack_Previews: PreviewProvider {
    
    static var previews: some View {
        DefaultVerticalRangeTrack(range: 0.2...0.8)
            .previewLayout(.fixed(width: 100, height: 300))
    }
}
#endif

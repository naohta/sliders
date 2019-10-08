import SwiftUI

public struct DefaultHorizontalRangeTrack<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let range: ClosedRange<V>
    
    public var body: some View {
        HRangeTrack(
            range: range,
            valueView: Rectangle()
                .foregroundColor(.accentColor)
                .frame(height: 3),
            maskView: Rectangle(),
            lowerLeadingOffset: 13.5,
            lowerTrailingOffset: 13.5,
            upperLeadingOffset: 13.5,
            upperTrailingOffset: 13.5
        )
        .frame(height: 3)
        .background(Color.secondary.opacity(0.25))
        .cornerRadius(1.5)
    }
}

#if DEBUG
struct DefaultHorizontalRangeTrack_Previews: PreviewProvider {
    static var previews: some View {
        DefaultHorizontalRangeTrack(range: 0.5...0.9)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
#endif

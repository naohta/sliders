import SwiftUI

public typealias HRangeTrack = HorizontalRangeTrack

public struct HorizontalRangeTrack<V, ValueView: View, MaskView: View>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint  {
    let range: ClosedRange<V>
    let bounds: ClosedRange<CGFloat>
    let valueView: AnyView
    let maskView: AnyView
    let lowerLeadingOffset: CGFloat
    let lowerTrailingOffset: CGFloat
    let upperLeadingOffset: CGFloat
    let upperTrailingOffset: CGFloat
    
    public var body: some View {
        let range = CGFloat(self.range.lowerBound)...CGFloat(self.range.upperBound)

        return GeometryReader { geometry in
            ZStack {
                self.valueView
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .mask(
                        self.maskView
                            .frame(
                                width: rangeDistance(
                                    overallLength: geometry.size.width,
                                    range: range,
                                    bounds: self.bounds,
                                    lowerStartOffset: self.lowerLeadingOffset,
                                    lowerEndOffset: self.lowerTrailingOffset,
                                    upperStartOffset: self.upperLeadingOffset,
                                    upperEndOffset: self.upperTrailingOffset
                                ),
                                height: geometry.size.height
                            )
                            .fixedSize()
                            .offset(
                                x: offsetFromCenterToRangeCenter(
                                    overallLength: geometry.size.width,
                                    range: range,
                                    bounds: self.bounds,
                                    lowerStartOffset: self.lowerLeadingOffset,
                                    lowerEndOffset: self.lowerTrailingOffset,
                                    upperStartOffset: self.upperLeadingOffset,
                                    upperEndOffset: self.upperTrailingOffset
                                )
                            )
                    )
            }
        }
        .frame(minHeight: 1)
    }
}

extension HorizontalRangeTrack {
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, valueView: ValueView, maskView: MaskView, lowerLeadingOffset: CGFloat = 0, lowerTrailingOffset: CGFloat = 0, upperLeadingOffset: CGFloat = 0, upperTrailingOffset: CGFloat = 0) {
        self.range = range
        self.bounds = CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound)
        self.valueView = AnyView(valueView)
        self.maskView = AnyView(maskView)
        self.lowerLeadingOffset = lowerLeadingOffset
        self.lowerTrailingOffset = lowerTrailingOffset
        self.upperLeadingOffset = upperLeadingOffset
        self.upperTrailingOffset = upperTrailingOffset
    }
}

extension HorizontalRangeTrack where ValueView == Capsule {
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, maskView: MaskView, lowerLeadingOffset: CGFloat = 0, lowerTrailingOffset: CGFloat = 0, upperLeadingOffset: CGFloat = 0, upperTrailingOffset: CGFloat = 0) {
        self.init(range: range, in: bounds, valueView: Capsule(), maskView: maskView, lowerLeadingOffset: lowerLeadingOffset, lowerTrailingOffset: lowerTrailingOffset, upperLeadingOffset: upperLeadingOffset, upperTrailingOffset: upperTrailingOffset)
    }
}

extension HorizontalRangeTrack where MaskView == Capsule {
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, valueView: ValueView, lowerLeadingOffset: CGFloat = 0, lowerTrailingOffset: CGFloat = 0, upperLeadingOffset: CGFloat = 0, upperTrailingOffset: CGFloat = 0) {
        self.init(range: range, in: bounds, valueView: valueView, maskView: Capsule(), lowerLeadingOffset: lowerLeadingOffset, lowerTrailingOffset: lowerTrailingOffset, upperLeadingOffset: upperLeadingOffset, upperTrailingOffset: upperTrailingOffset)
    }
}

extension HorizontalRangeTrack where ValueView == Capsule, MaskView == Capsule {
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, lowerLeadingOffset: CGFloat = 0, lowerTrailingOffset: CGFloat = 0, upperLeadingOffset: CGFloat = 0, upperTrailingOffset: CGFloat = 0) {
        self.init(range: range, in: bounds, valueView: Capsule(), maskView: Capsule(), lowerLeadingOffset: lowerLeadingOffset, lowerTrailingOffset: lowerTrailingOffset, upperLeadingOffset: upperLeadingOffset, upperTrailingOffset: upperTrailingOffset)
    }
}

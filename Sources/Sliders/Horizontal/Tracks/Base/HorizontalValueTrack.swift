import SwiftUI

public typealias HTrack = HorizontalValueTrack

public struct HorizontalValueTrack<V, ValueView: View, MaskView: View>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint  {
    let value: V
    let bounds: ClosedRange<CGFloat>
    let valueView: AnyView
    let maskView: AnyView
    let leadingOffset: CGFloat
    let trailingOffset: CGFloat
    
    public var body: some View {
        let value = CGFloat(self.value)

        return GeometryReader { geometry in
            ZStack {
                self.valueView
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .mask(
                        self.maskView
                            .frame(
                                width: distanceFromZero(
                                    overallLength: geometry.size.width,
                                    value: value,
                                    bounds: self.bounds,
                                    startOffset: self.leadingOffset,
                                    endOffset: self.trailingOffset
                                ),
                                height: geometry.size.height
                            )
                            .fixedSize()
                            .offset(
                                x: offsetFromCenterToValueDistanceCenter(
                                    overallLength: geometry.size.width,
                                    value: value,
                                    bounds: self.bounds,
                                    startOffset: self.leadingOffset,
                                    endOffset: self.trailingOffset
                                )
                            )
                    )
            }
            
        }
        .frame(minHeight: 1)
    }
}

extension HorizontalValueTrack {
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, valueView: ValueView, maskView: MaskView, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) {
        self.value = value
        self.bounds = CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound)
        self.valueView = AnyView(valueView)
        self.maskView = AnyView(maskView)
        self.leadingOffset = leadingOffset
        self.trailingOffset = trailingOffset
    }
}

extension HorizontalValueTrack where ValueView == Capsule {
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, maskView: MaskView, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) {
        self.init(value: value, in: bounds, valueView: Capsule(), maskView: maskView, leadingOffset: leadingOffset, trailingOffset: trailingOffset)
    }
}

extension HorizontalValueTrack where MaskView == Capsule {
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, valueView: ValueView, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) {
        self.init(value: value, in: bounds, valueView: valueView, maskView: Capsule(), leadingOffset: leadingOffset, trailingOffset: trailingOffset)
    }
}

extension HorizontalValueTrack where ValueView == Capsule, MaskView == Capsule {
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) {
        self.init(value: value, in: bounds, valueView: Capsule(), maskView: Capsule(), leadingOffset: leadingOffset, trailingOffset: trailingOffset)
    }
}

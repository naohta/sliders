import SwiftUI

public typealias VTrack = VerticalValueTrack

public struct VerticalValueTrack<V, ValueView: View, MaskView: View>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint  {
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
                                width: geometry.size.width,
                                height: distanceFromZero(
                                    overallLength: geometry.size.height,
                                    value: value,
                                    bounds: self.bounds,
                                    startOffset: self.leadingOffset,
                                    endOffset: self.trailingOffset
                                )
                            )
                            .fixedSize()
                            .offset(
                                y: -offsetFromCenterToValueDistanceCenter(
                                    overallLength: geometry.size.height,
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

extension VerticalValueTrack {
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, valueView: ValueView, maskView: MaskView, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) {
        self.value = value
        self.bounds = CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound)
        self.valueView = AnyView(valueView)
        self.maskView = AnyView(maskView)
        self.leadingOffset = leadingOffset
        self.trailingOffset = trailingOffset
    }
}

extension VerticalValueTrack where ValueView == Capsule {
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, maskView: MaskView, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) {
        self.init(value: value, in: bounds, valueView: Capsule(), maskView: maskView, leadingOffset: leadingOffset, trailingOffset: trailingOffset)
    }
}

extension VerticalValueTrack where MaskView == Capsule {
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, valueView: ValueView, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) {
        self.init(value: value, in: bounds, valueView: valueView, maskView: Capsule(), leadingOffset: leadingOffset, trailingOffset: trailingOffset)
    }
}

extension VerticalValueTrack where ValueView == Capsule, MaskView == Capsule {
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) {
        self.init(value: value, in: bounds, valueView: Capsule(), maskView: Capsule(), leadingOffset: leadingOffset, trailingOffset: trailingOffset)
    }
}

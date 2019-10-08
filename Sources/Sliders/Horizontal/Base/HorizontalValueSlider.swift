import SwiftUI

public typealias HSlider = HorizontalValueSlider

public struct HorizontalValueSlider<V, TrackView: View, ThumbView : View>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let value: Binding<V>
    let bounds: ClosedRange<CGFloat>
    let step: CGFloat
    let trackView: AnyView
    let thumbView: AnyView
    let thumbSize: CGSize
    
    let onEditingChanged: (Bool) -> Void
    
    @State
    private var dragOffsetX: CGFloat? = nil
    
    public var body: some View {
        let value = CGFloat(self.value.wrappedValue)
        
        return GeometryReader { geometry in
            ZStack {
                self.trackView
                
                self.thumbView
                    .frame(width: self.thumbSize.width, height: self.thumbSize.height)
                    .fixedSize()
                    .offset(x: offsetFromCenterToValue(
                        overallLength: geometry.size.width - self.thumbSize.width,
                        value: value,
                        bounds: self.bounds
                    ))
                    .gesture(
                        DragGesture()
                            .onChanged { gestureValue in
                                let availableLength = geometry.size.width - self.thumbSize.width
                                
                                if self.dragOffsetX == nil {
                                    let computedValueOffset = offsetFromCenterToValue(
                                        overallLength: availableLength,
                                        value: value,
                                        bounds: self.bounds
                                    )
                                    self.dragOffsetX = gestureValue.startLocation.x - computedValueOffset
                                }
                                
                                let locationOffset = gestureValue.location.x - (self.dragOffsetX ?? 0)
                                let relativeValue = relativeValueFrom(overallLength: availableLength, centerOffset: locationOffset)
                                let computedValue = valueFrom(relativeValue: relativeValue, bounds: self.bounds, step: self.step)
                                self.value.wrappedValue = V(computedValue)
                                self.onEditingChanged(true)
                            }
                            .onEnded { _ in
                                self.dragOffsetX = nil
                                self.onEditingChanged(false)
                            }
                    )
            }
            /// If opacity is zero gesture is never called.
            .background(Color.white.opacity(0.00000000001))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gestureValue in
                        /// Coordinates here are not offset from center.
                        let relativeValue: CGFloat = (gestureValue.location.x - self.thumbSize.width / 2) / (geometry.size.width - self.thumbSize.width)
                        let computedValue = valueFrom(relativeValue: relativeValue, bounds: self.bounds, step: self.step)
                        self.value.wrappedValue = V(computedValue)
                        self.onEditingChanged(true)
                    }
                    .onEnded { _ in
                        self.onEditingChanged(false)
                    }
            )
        }
        .frame(minHeight: 44)
    }
}

// MARK: Inits

extension HorizontalValueSlider {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, trackView: TrackView, thumbView: ThumbView, thumbSize: CGSize = CGSize(width: 27, height: 27), onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.value = value
        self.bounds = CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound)
        self.step = CGFloat(step)
        self.trackView = AnyView(trackView)
        self.thumbView = AnyView(thumbView)
        self.thumbSize = thumbSize
        self.onEditingChanged = onEditingChanged
    }
}

extension HorizontalValueSlider where TrackView == DefaultHorizontalValueTrack<V>, ThumbView == DefaultThumb {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, thumbSize: CGSize = CGSize(width: 27, height: 27), onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(value: value, in: bounds, step: step, trackView: DefaultHorizontalValueTrack(value: value.wrappedValue), thumbView: DefaultThumb(), thumbSize: thumbSize, onEditingChanged: onEditingChanged)
    }
}

extension HorizontalValueSlider where ThumbView == DefaultThumb {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, trackView: TrackView, thumbSize: CGSize = CGSize(width: 27, height: 27), onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(value: value, in: bounds, step: step, trackView: trackView, thumbView: DefaultThumb(), thumbSize: thumbSize, onEditingChanged: onEditingChanged)
    }
}

#if DEBUG
struct HorizontalValueSlider_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalValueSlider(value: .constant(0.5))
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
#endif

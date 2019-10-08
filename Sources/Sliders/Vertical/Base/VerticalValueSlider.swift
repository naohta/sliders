import SwiftUI

public typealias VSlider = VerticalValueSlider

public struct VerticalValueSlider<V, TrackView: View, ThumbView : View>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let value: Binding<V>
    let bounds: ClosedRange<CGFloat>
    let step: CGFloat
    let trackView: AnyView
    let thumbView: AnyView
    let thumbSize: CGSize
    
    let onEditingChanged: (Bool) -> Void
    
    @State
    private var dragOffsetY: CGFloat? = nil
    
    public var body: some View {
        let value = CGFloat(self.value.wrappedValue)
        
        return GeometryReader { geometry in
            ZStack {
                self.trackView
                
                self.thumbView
                    .frame(width: self.thumbSize.width, height: self.thumbSize.height)
                    .fixedSize()
                    .offset(y: -offsetFromCenterToValue(
                        overallLength: geometry.size.height - self.thumbSize.height,
                        value: value,
                        bounds: self.bounds
                    ))
                    .gesture(
                        DragGesture()
                            .onChanged { gestureValue in
                                let availableLength = geometry.size.height - self.thumbSize.height
                                
                                if self.dragOffsetY == nil {
                                    let computedValueOffset = -offsetFromCenterToValue(
                                        overallLength: availableLength,
                                        value: value,
                                        bounds: self.bounds
                                    )
                                    self.dragOffsetY = gestureValue.startLocation.y - computedValueOffset
                                }
                                
                                let locationOffset = gestureValue.location.y - (self.dragOffsetY ?? 0)
                                let relativeValue = relativeValueFrom(overallLength: availableLength, centerOffset: -locationOffset)
                                let computedValue = valueFrom(relativeValue: relativeValue, bounds: self.bounds, step: self.step)
                                self.value.wrappedValue = V(computedValue)
                                self.onEditingChanged(true)
                            }
                            .onEnded { _ in
                                self.dragOffsetY = nil
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
                        let relativeValue: CGFloat = 1 - (gestureValue.location.y - self.thumbSize.height / 2) / (geometry.size.height - self.thumbSize.height)
                        let computedValue = valueFrom(relativeValue: relativeValue, bounds: self.bounds, step: self.step)
                        self.value.wrappedValue = V(computedValue)
                        self.onEditingChanged(true)
                    }
                    .onEnded { _ in
                        self.onEditingChanged(false)
                    }
            )
        }
        .frame(minWidth: 44)
    }
}

// MARK: Inits

extension VerticalValueSlider {
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

extension VerticalValueSlider where TrackView == DefaultVerticalValueTrack<V>, ThumbView == DefaultThumb {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, thumbSize: CGSize = CGSize(width: 27, height: 27), onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(value: value, in: bounds, step: step, trackView: DefaultVerticalValueTrack(value: value.wrappedValue), thumbView: DefaultThumb(), thumbSize: thumbSize, onEditingChanged: onEditingChanged)
    }
}

extension VerticalValueSlider where ThumbView == DefaultThumb {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, trackView: TrackView, thumbSize: CGSize = CGSize(width: 27, height: 27), onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(value: value, in: bounds, step: step, trackView: trackView, thumbView: DefaultThumb(), thumbSize: thumbSize, onEditingChanged: onEditingChanged)
    }
}

#if DEBUG
struct VerticalValueSlider_Previews: PreviewProvider {
    static var previews: some View {
        VerticalValueSlider(value: .constant(0.5))
            .previewLayout(.fixed(width: 100, height: 300))
    }
}
#endif

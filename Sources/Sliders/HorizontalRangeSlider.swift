import SwiftUI

public typealias HRangeSlider = HorizontalRangeSlider

public struct HorizontalRangeSlider<V, TrackView: View, LowerThumbView : InsettableShape, UpperThumbView: InsettableShape> : View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    @Environment(\.sliderStyle)
    var style
    
    @Environment(\.isEnabled)
    var isEnabled
    
    @usableFromInline
    var preferences = SliderPreferences()
    
    let range: Binding<ClosedRange<V>>
    let bounds: ClosedRange<V>
    let step: V.Stride
    
    let trackView: TrackView
    let lowerThumbView: LowerThumbView
    let upperThumbView: UpperThumbView
    
    let onEditingChanged: (Bool) -> Void
    
    @State
    private var dragOffsetX: CGFloat? = nil

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                self.trackView
                    .frame(width: geometry.size.width, height: self.thickness)
                    .trackStyle(
                        CustomTrackStyle(
                            valueColor: self.valueColor,
                            backgroundColor: self.trackColor,
                            borderColor: self.trackBorderColor,
                            borderWidth: self.trackBorderWidth,
                            lowerStartOffset: self.thumbSize.width / 2,
                            lowerEndOffset: self.thumbSize.width / 2 + self.thumbSize.width,
                            upperStartOffset: self.thumbSize.width / 2 + self.thumbSize.width,
                            upperEndOffset: self.thumbSize.width / 2
                        )
                    )
                
                self.lowerThumbView
                    .overlay(
                        self.lowerThumbView.strokeBorder(self.thumbBorderColor, lineWidth: self.thumbBorderWidth)
                    )
                    .frame(width: self.thumbSize.width, height:self.thumbSize.height)
                    .foregroundColor(self.thumbColor)
                    .shadow(color:self.thumbShadowColor, radius: self.thumbShadowRadius, x: self.thumbShadowX, y: self.thumbShadowY)
                    .offset(x: offsetFromCenterToValue(
                        overallLength: geometry.size.width - self.thumbSize.width,
                        value: CGFloat(self.range.wrappedValue.lowerBound),
                        bounds: CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound),
                        startOffset: 0,
                        endOffset: self.thumbSize.width
                    ))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let bounds = CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound)
                                let availableLength = geometry.size.width - self.thumbSize.width * 2
                                
                                if self.dragOffsetX == nil {
                                    let computedValueOffset = offsetFromCenterToValue(
                                        overallLength: availableLength,
                                        value: CGFloat(self.range.wrappedValue.lowerBound),
                                        bounds: CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound),
                                        startOffset: 0,
                                        endOffset: self.thumbSize.width
                                    )
                                    self.dragOffsetX = value.startLocation.x - computedValueOffset
                                }

                                let locationOffset = value.location.x - (self.dragOffsetX ?? 0)
                                let relativeValue = relativeValueFrom(overallLength: availableLength, centerOffset: locationOffset)
                                let computedLowerBound = valueFrom(relativeValue: relativeValue, bounds: bounds, step: CGFloat(self.step))
                                let computedUpperBound = max(computedLowerBound, CGFloat(self.range.wrappedValue.upperBound))
                                self.range.wrappedValue = (V(computedLowerBound)...V(computedUpperBound)).clamped(to: self.bounds)
                                self.onEditingChanged(true)
                            }
                            .onEnded { _ in
                                self.dragOffsetX = nil
                                self.onEditingChanged(false)
                            }
                    )

                self.upperThumbView
                    .overlay(
                        self.upperThumbView.strokeBorder(self.thumbBorderColor, lineWidth: self.thumbBorderWidth)
                    )
                    .frame(width: self.thumbSize.width, height:self.thumbSize.height)
                    .foregroundColor(self.thumbColor)
                    .shadow(color:self.thumbShadowColor, radius: self.thumbShadowRadius, x: self.thumbShadowX, y: self.thumbShadowY)
                    .offset(x: offsetFromCenterToValue(
                        overallLength: geometry.size.width - self.thumbSize.width,
                        value: CGFloat(self.range.wrappedValue.upperBound),
                        bounds: CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound),
                        startOffset: self.thumbSize.width,
                        endOffset: 0
                    ))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let bounds = CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound)
                                let availableLength = geometry.size.width - self.thumbSize.width * 2
                                
                                if self.dragOffsetX == nil {
                                    let computedValueOffset = offsetFromCenterToValue(
                                        overallLength: availableLength,
                                        value: CGFloat(self.range.wrappedValue.upperBound),
                                        bounds: CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound),
                                        startOffset: self.thumbSize.width,
                                        endOffset: 0
                                    )
                                    self.dragOffsetX = value.startLocation.x - computedValueOffset
                                }

                                let locationOffset = value.location.x - (self.dragOffsetX ?? 0)
                                let relativeValue = relativeValueFrom(overallLength: availableLength, centerOffset: locationOffset)
                                
                                let computedUpperBound = valueFrom(relativeValue: relativeValue, bounds: bounds, step: CGFloat(self.step))
                                let computedLowerBound = min(computedUpperBound, CGFloat(self.range.wrappedValue.lowerBound))
                                self.range.wrappedValue = (V(computedLowerBound)...V(computedUpperBound)).clamped(to: self.bounds)
                                self.onEditingChanged(true)
                            }
                            .onEnded { _ in
                                self.dragOffsetX = nil
                                self.onEditingChanged(false)
                            }
                    )
            }
            .frame(height: self.height)
        }
        .frame(height: self.height)
        .drawingGroup()
        .opacity(self.isEnabled ? 1.0 : 0.5)
    }
}

// MARK: Inits

extension HorizontalRangeSlider {
    /// Creates an instance that selects a range from within a range.
    ///
    /// - Parameters:
    ///     - range: The selected range within `bounds`.
    ///     - bounds: The range of the valid values. Defaults to `0...1`.
    ///     - step: The distance between each valid value. Defaults to `0.001`.
    ///     - onEditingChanged: A callback for when editing begins and ends.
    ///
    /// `onEditingChanged` will be called when editing begins and ends. For
    /// example, on iOS, a `RangeSlider` is considered to be actively editing while
    /// the user is touching the thumb and sliding it around the track.
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0...1, step: V.Stride = 0.001, trackView: TrackView, lowerThumbView: LowerThumbView, upperThumbView: UpperThumbView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.range = range
        self.bounds = bounds
        self.step = step

        self.trackView = trackView
        self.lowerThumbView = lowerThumbView
        self.upperThumbView = upperThumbView

        self.onEditingChanged = onEditingChanged
    }
}

extension HorizontalRangeSlider where TrackView == HorizontalRangeTrack<V, Capsule, Capsule> {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, lowerThumbView: LowerThumbView, upperThumbView: UpperThumbView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        let trackView = HorizontalRangeTrack(range: range, in: bounds)
        self.init(range: range, in: bounds, step: step, trackView: trackView, lowerThumbView: lowerThumbView, upperThumbView: upperThumbView, onEditingChanged: onEditingChanged)
    }
}

extension HorizontalRangeSlider where LowerThumbView == Capsule, UpperThumbView == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, trackView: TrackView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: trackView, lowerThumbView: Capsule(), upperThumbView: Capsule(), onEditingChanged: onEditingChanged)
    }
}

extension HorizontalRangeSlider where TrackView == HorizontalRangeTrack<V, Capsule, Capsule>, LowerThumbView == Capsule, UpperThumbView == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        let trackView = HorizontalRangeTrack(range: range, in: bounds)
        self.init(range: range, in: bounds, step: step, trackView: trackView, lowerThumbView: Capsule(), upperThumbView: Capsule(), onEditingChanged: onEditingChanged)
    }
}

// MARK: Inits for same LowerThumbView and UpperThumbView

extension HorizontalRangeSlider where LowerThumbView == UpperThumbView {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, trackView: TrackView, thumbView: LowerThumbView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: trackView, lowerThumbView: thumbView, upperThumbView: thumbView, onEditingChanged: onEditingChanged)
    }
}

extension HorizontalRangeSlider where TrackView == HorizontalRangeTrack<V, Capsule, Capsule>, LowerThumbView == UpperThumbView {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, thumbView: LowerThumbView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        let trackView = HorizontalRangeTrack(range: range, in: bounds)
        self.init(range: range, in: bounds, step: step, trackView: trackView, lowerThumbView: thumbView, upperThumbView: thumbView, onEditingChanged: onEditingChanged)
    }
}

// MARK: Values

extension HorizontalRangeSlider {
    var height: CGFloat {
        preferences.height ?? style.height
    }
    
    var thickness: CGFloat {
        preferences.thickness ?? style.thickness
    }
    
    var thumbSize: CGSize {
        preferences.thumbSize ?? style.thumbSize
    }
    
    var thumbColor: Color {
        preferences.thumbColor ?? style.thumbColor
    }
    
    var thumbBorderColor: Color {
        preferences.thumbBorderColor ?? style.thumbBorderColor
    }
    
    var thumbBorderWidth: CGFloat {
        preferences.thumbBorderWidth ?? style.thumbBorderWidth
    }
    
    var thumbShadowColor: Color {
        preferences.thumbShadowColor ?? style.thumbShadowColor
    }
    
    var thumbShadowRadius: CGFloat {
        preferences.thumbShadowRadius ?? style.thumbShadowRadius
    }
    
    var thumbShadowX: CGFloat {
        preferences.thumbShadowX ?? style.thumbShadowX
    }
    
    var thumbShadowY: CGFloat {
        preferences.thumbShadowY ?? style.thumbShadowY
    }
    
    var valueColor: Color {
        preferences.valueColor ?? style.valueColor
    }
    
    var trackColor: Color {
        preferences.trackColor ?? style.trackColor
    }
    
    var trackBorderColor: Color {
        preferences.trackBorderColor ?? style.trackBorderColor
    }
    
    var trackBorderWidth: CGFloat {
        preferences.trackBorderWidth ?? style.trackBorderWidth
    }
}

// MARK: Modifiers

public extension HorizontalRangeSlider {
    @inlinable func height(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.height = length
        return copy
    }
    
    @inlinable func thickness(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.thickness = length
        return copy
    }
    
    @inlinable func thumbSize(_ size: CGSize?) -> Self {
        var copy = self
        copy.preferences.thumbSize = size
        return copy
    }
    
    @inlinable func thumbColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.thumbColor = color
        return copy
    }
    
    @inlinable func thumbBorderColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.thumbBorderColor = color
        return copy
    }
    
    @inlinable func thumbBorderWidth(_ width: CGFloat?) -> Self {
        var copy = self
        copy.preferences.thumbBorderWidth = width
        return copy
    }
    
    @inlinable func thumbShadowColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.thumbShadowColor = color
        return copy
    }

    @inlinable func thumbShadowRadius(_ radius: CGFloat?) -> Self {
        var copy = self
        copy.preferences.thumbShadowRadius = radius
        return copy
    }

    @inlinable func thumbShadowX(_ offset: CGFloat?) -> Self {
        var copy = self
        copy.preferences.thumbShadowX = offset
        return copy
    }

    @inlinable func thumbShadowY(_ offset: CGFloat?) -> Self {
        var copy = self
        copy.preferences.thumbShadowY = offset
        return copy
    }
    
    @inlinable func valueColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.valueColor = color
        return copy
    }
    
    @inlinable func trackColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.trackColor = color
        return copy
    }

    @inlinable func trackBorderColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.trackBorderColor = color
        return copy
    }

    @inlinable func trackBorderWidth(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.trackBorderWidth = length
        return copy
    }
}

#if DEBUG

struct HorizontalRangeSlider_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalRangeSlider(range: .constant(0...1))
    }
}

#endif

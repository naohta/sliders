import SwiftUI

public typealias HRangeTrack = HorizontalRangeTrack

public struct HorizontalRangeTrack<V, ValueView: View, TrackShape: InsettableShape>: View where V : BinaryFloatingPoint {
    @Environment(\.trackStyle)
    var style
    
    @usableFromInline
    var preferences = TrackPreferences()
    
    let range: Binding<ClosedRange<V>>
    let bounds: ClosedRange<V>
    let valueView: ValueView
    let trackShape: TrackShape
        
    public var body: some View {
        GeometryReader { geometry in
            self.valueView
                .foregroundColor(self.valueColor)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .mask(
                    self.valueView
                        .frame(
                            width: rangeDistance(
                                overallLength: geometry.size.width,
                                range: CGFloat(self.range.wrappedValue.lowerBound)...CGFloat(self.range.wrappedValue.upperBound),
                                bounds: CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound),
                                lowerStartOffset: self.lowerStartOffset,
                                lowerEndOffset: self.lowerEndOffset,
                                upperStartOffset: self.upperStartOffset,
                                upperEndOffset: self.upperEndOffset
                            ),
                            height: geometry.size.height
                        )
                        .fixedSize()
                        .offset(
                            x: offsetFromCenterToRangeCenter(
                                overallLength: geometry.size.width,
                                range: CGFloat(self.range.wrappedValue.lowerBound)...CGFloat(self.range.wrappedValue.upperBound),
                                bounds: CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound),
                                lowerStartOffset: self.lowerStartOffset,
                                lowerEndOffset: self.lowerEndOffset,
                                upperStartOffset: self.upperStartOffset,
                                upperEndOffset: self.upperEndOffset
                            )
                        )
                )
                .overlay(
                    self.trackShape
                        .strokeBorder(self.borderColor, lineWidth: self.borderWidth)
                )
                .background(self.backgroundColor)
                    .mask(
                        self.trackShape.frame(width: geometry.size.width, height: geometry.size.height)
                )
                .drawingGroup()
        }

    }
}

extension HorizontalRangeTrack {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, valueView: ValueView, trackShape: TrackShape) {
        self.range = range
        self.bounds = bounds
        self.valueView = valueView
        self.trackShape = trackShape
    }
}

extension HorizontalRangeTrack where TrackShape == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, valueView: ValueView) {
        self.init(range: range, in: bounds, valueView: valueView, trackShape: Capsule())
    }
}

extension HorizontalRangeTrack where ValueView == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, trackShape: TrackShape) {
        self.init(range: range, in: bounds, valueView: Capsule(), trackShape: trackShape)
    }
}

extension HorizontalRangeTrack where TrackShape == Capsule, ValueView == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0) {
        self.init(range: range, in: bounds, valueView: Capsule(), trackShape: Capsule())
    }
}

// MARK: Values

extension HorizontalRangeTrack {
    var valueColor: Color {
        preferences.valueColor ?? style.valueColor
    }
    
    var backgroundColor: Color {
        preferences.backgroundColor ?? style.backgroundColor
    }
    
    var borderColor: Color {
        preferences.borderColor ?? style.borderColor
    }
    
    var borderWidth: CGFloat {
        preferences.borderWidth ?? style.borderWidth
    }
    
    var startOffset: CGFloat {
        preferences.startOffset ?? style.startOffset
    }
    
    var endOffset: CGFloat {
        preferences.endOffset ?? style.endOffset
    }
    
    var lowerStartOffset: CGFloat {
        preferences.lowerStartOffset ?? style.lowerStartOffset
    }
    
    var lowerEndOffset: CGFloat {
        preferences.lowerEndOffset ?? style.lowerEndOffset
    }
    
    var upperStartOffset: CGFloat {
        preferences.upperStartOffset ?? style.upperStartOffset
    }
    
    var upperEndOffset: CGFloat {
        preferences.upperEndOffset ?? style.upperEndOffset
    }
}

// MARK: Modifiers

public extension HorizontalRangeTrack {
    @inlinable func valueColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.valueColor = color
        return copy
    }
    
    @inlinable func backgroundColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.backgroundColor = color
        return copy
    }

    @inlinable func borderColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.borderColor = color
        return copy
    }

    @inlinable func borderWidth(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.borderWidth = length
        return copy
    }
    
    @inlinable func startOffset(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.startOffset = length
        return copy
    }
    
    @inlinable func endOffset(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.endOffset = length
        return copy
    }
    
    @inlinable func lowerStartOffset(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.lowerStartOffset = length
        return copy
    }
    
    @inlinable func lowerEndOffset(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.lowerEndOffset = length
        return copy
    }
    
    @inlinable func upperStartOffset(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.upperStartOffset = length
        return copy
    }
    
    @inlinable func upperEndOffset(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.upperEndOffset = length
        return copy
    }
}

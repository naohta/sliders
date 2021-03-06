## SwiftUI horizontal and vertical sliders for value and range.

SwiftUI Sliders with custom styles for iOS, macOS and Mac Catalyst.

<center>
<img src="Resources/sliders.png"/>
</center>

## How to use

Add this swift package to  your project
```
git@github.com:spacenation/sliders.git
```

Import and use

```swift
import Sliders
import SwiftUI

struct ContentView: View {
    @State var value = 0.5
    @State var range = 0.2...0.8
    
    var body: some View {
        Group {
            HorizontalValueSlider(value: $value)
            VerticalRangeSlider(range: $range)
        }
    }
}
```
For more examples open `/Examples/SlidersExamples.xcodeproj`

## Customizations

### Local modifiers
```swift
HorizontalRangeSlider(
    range: $range,
    trackView: RoundedRectangle(cornerRadius: 16),
    valueView: LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .leading, endPoint: .trailing),
    thumbView: HalfCapsule()
)
.height(60)
.thickness(8)
/// Thumb
.thumbSize(CGSize(width: 16, height: 24))
.thumbColor(.red)
.thumbCornerRadius(8)
.thumbBorderColor(.white)
.thumbBorderWidth(1)
.thumbShadowColor(.black)
.thumbShadowRadius(3)
.thumbShadowX(1)
.thumbShadowY(0)
/// Value
.valueColor(.blue)
/// Track
.trackColor(.black)
.trackBorderColor(.yellow)
.trackBorderWidth(1)
/// Style
.sliderStyle(
    PlainSliderStyle()
)
```

### Apply scope-wide styles
```swift
manySlidersView
    .sliderStyle(
        YourSliderStyle()
    )
```

### Environment Values
```swift
view.environment(\.sliderStyle.height, 44)
view.environment(\.sliderStyle.thickness, 3)
view.environment(\.sliderStyle.thumbSize, CGSize(width: 16, height: 24))
view.environment(\.sliderStyle.thumbColor, .red)
view.environment(\.sliderStyle.thumbBorderColor, .blue)
view.environment(\.sliderStyle.thumbBorderWidth, 1)
view.environment(\.sliderStyle.thumbShadowColor, .black)
view.environment(\.sliderStyle.thumbShadowRadius, 2)
view.environment(\.sliderStyle.thumbShadowX, 1.5)
view.environment(\.sliderStyle.thumbShadowY, 1.5)
view.environment(\.sliderStyle.valueColor, .blue)
view.environment(\.sliderStyle.trackColor, .green)
view.environment(\.sliderStyle.trackBorderColor, .grey)
view.environment(\.sliderStyle.trackBorderWidth, 2)

view.environment(\.sliderStyle, PlainSliderStyle())
```

## SDKs
- iOS 13+
- Mac Catalyst 13.0+
- macOS 10.15+
- Xcode 11.0+

## Version 1.0.0
Stable version will be released as soon as XCode 11 GM becomes available. We will strictly follow semantic versioning moving forward.

## Contibutions
Feel free to contribute via fork/pull request to master branch. If you want to request a feature or report a bug please start a new issue.

import SwiftUI
import Sliders

struct VerticalSliderExamplesView: View {
    @EnvironmentObject var model: Model

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Group {
                    VerticalValueSlider(value: $model.value1, step: 0.01)

                    VerticalValueSlider(
                        value: $model.value2,
                        trackView: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .bottom, endPoint: .top)
                    )

                    VSlider(
                        value: $model.value3,
                        trackView:
                            VTrack(value: $model.value3, in: 0.0...1.0)
                                .frame(width: 8)
                                .animation(.spring(response: 0.7, dampingFraction: 0.4))
                    )
                    .thumbSize(CGSize(width: 16, height: 16))
                    .trackBorderColor(Color.white.opacity(0.2))
                    .trackBorderWidth(1)
                    .thickness(6)

                    VerticalValueSlider(
                        value: $model.value4,
                        trackView: LinearGradient(gradient: Gradient(colors: [.white, .blue, .white]), startPoint: .bottom, endPoint: .top)
                    )
                    .thumbSize(CGSize(width: 16, height: 48))
                    .thickness(6)

                    VerticalValueSlider(
                        value: $model.value5,
                        trackView: VTrack(
                            value: $model.value5,
                            valueView: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .bottom, endPoint: .top),
                            trackShape: Capsule()
                        )
                    )
                    .thickness(36)
                    .thumbSize(.zero)
                    
                    VerticalValuesTrack(valueColorPairs: [
                        .init(value: 0.9, color: Color.white.opacity(0.8)),
                        .init(value: 0.6, color: Color.purple.opacity(0.8)),
                        .init(value: $model.value5, color: Color.blue.opacity(0.8))
                    ])
                }

                Group {
                    VerticalRangeSlider(range: $model.range1, step: 0.01)
                        .sliderStyle(
                            PlainSliderStyle(valueColor: .purple)
                        )

                    VerticalRangeSlider(range: $model.range2)
                        .thumbBorderWidth(8)
                        .thumbBorderColor(.white)
                        .sliderStyle(
                            PlainSliderStyle(valueColor: .blue)
                        )

                    VerticalRangeSlider(
                        range: $model.range3,
                        trackView: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .bottom, endPoint: .top),
                        thumbView: RoundedRectangle(cornerRadius: 8)
                    )
                    .thumbSize(CGSize(width: 32, height: 32))

                    VerticalRangeSlider(
                        range: $model.range4,
                        trackView: LinearGradient(gradient: Gradient(colors: [.green, .yellow, .red]), startPoint: .bottom, endPoint: .top),
                        thumbView: Capsule()
                    )
                    .thumbSize(CGSize(width: 16, height: 24))
                    .thickness(8)

                    VerticalRangeSlider(
                        range: $model.range5,
                        thumbView: RoundedRectangle(cornerRadius: 4)
                    )

                    VerticalRangeSlider(
                        range: $model.range6,
                        trackView: VRangeTrack(
                            range: $model.range6,
                            valueView: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .bottom, endPoint: .top)
                        ),
                        thumbView: Capsule()
                    )
                    .thumbSize(CGSize(width: 26, height: 26))
                    .thickness(28)
                    .trackBorderColor(.gray)
                    .trackBorderWidth(1)

                    VerticalRangeSlider(
                        range: $model.range7,
                        trackView: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .bottom, endPoint: .top)
                    )
                    .thumbSize(CGSize(width: 48, height: 24))
                    .thickness(8)
                    .width(56)

                    VerticalRangeSlider(
                        range: $model.range8,
                        trackView: VerticalRangeTrack(
                            range: $model.range8,
                            valueView: LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .bottom, endPoint: .top),
                            trackShape: RoundedRectangle(cornerRadius: 16)
                        )
                    )
                    .width(72)
                    .thickness(64)
                    .thumbSize(CGSize(width: 64, height: 32))
                    .thumbBorderColor(Color.black.opacity(0.3))
                    .thumbBorderWidth(2)

                    VerticalRangeSlider(
                        range: $model.range9,
                        trackView: VerticalRangeTrack(
                            range: $model.range9,
                            valueView: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .bottom, endPoint: .top), trackShape: Ellipse()
                        )
                    )
                    .width(72)
                    .thickness(48)
                    .thumbSize(CGSize(width: 56, height: 16))
                    .trackBorderColor(Color.white.opacity(0.3))
                    .trackBorderWidth(2)
                }
            }

        }
        .padding()
    }
}

struct VerticalSliderExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalSliderExamplesView().environmentObject(Model.preview)
    }
}

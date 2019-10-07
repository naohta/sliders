import SwiftUI
import Sliders

struct HorizontalSliderExamplesView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        ScrollView {
            Group {
                
                //Slider(value: $model.value1, in: 0.0...1.0)
                XSlider(value: $model.value1, in: 0.0...1.0)
                
                //HTrack(value: $model.value1).frame(height: 8).animation(.spring())
//
//                XTrack(value: model.value1, valueView:
//                    LinearGradient(gradient: Gradient(colors: [.red, .green]), startPoint: .leading, endPoint: .trailing)
//                )
//                .frame(height: 8)
//                .background(Color.white)
//                .cornerRadius(8)
                
                XTrack(value: model.value1)
                
                XSlider(value: $model.value1, in: 0.0...1.0)
                
                XSlider(value: $model.value2, trackView:
                    LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
                        .frame(height: 8)
                        .cornerRadius(4)
                )
                

                XSlider(
                    value: $model.value3,
                    trackView:
                        XTrack(
                            value: model.value3,
                            valueView: Rectangle()
                                .foregroundColor(.accentColor)
                                .frame(height: 6)
                        )
                        .background(Color.white)
                        .frame(height: 6)
                        .cornerRadius(3)
                        .overlay(
                            Capsule().strokeBorder(Color.white.opacity(0.5), lineWidth: 1)
                        )
                        .animation(.spring(response: 0.7, dampingFraction: 0.4)),
                    thumbSize: CGSize(width: 16, height: 16)
                )
                
                XHorizontalValueSlider(
                    value: $model.value4,
                    trackView:
                        LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .leading, endPoint: .trailing)
                            .frame(height: 6)
                            .cornerRadius(3),
                    thumbView:
                        Capsule(),
                    thumbSize: CGSize(width: 48, height: 16)
                )
                
                XHorizontalValueSlider(
                    value: $model.value5,
                    trackView:
                        XHorizontalValueTrack(
                            value: model.value5,
                            valueView: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .leading, endPoint: .trailing),
                            maskView: Rectangle()
                        )
                        .frame(height: 30)
                        .background(Color.white)
                        .cornerRadius(15)
                        .animation(.easeInOut(duration: 0.5)),
                    thumbView:
                        EmptyView(),
                    thumbSize: .zero
                )

//
//                HorizontalValuesTrack(valueColorPairs: [
//                    .init(value: 0.9, color: Color.white.opacity(0.8)),
//                    .init(value: 0.6, color: Color.purple.opacity(0.8)),
//                    .init(value: $model.value5, color: Color.blue.opacity(0.8))
//                ])
//            }
//
//            Group {
//                HorizontalRangeSlider(range: $model.range1)
//                    .thumbSize(CGSize(width: 40, height: 27))
//                    .sliderStyle(
//                        PlainSliderStyle(valueColor: .purple)
//                    )
//
//                HorizontalRangeSlider(range: $model.range2)
//                    .thumbBorderWidth(8)
//                    .thumbBorderColor(.white)
//                    .sliderStyle(
//                        PlainSliderStyle(valueColor: .blue)
//                    )
//
//                HorizontalRangeSlider(
//                    range: $model.range3,
//                    trackView: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing),
//                    thumbView: RoundedRectangle(cornerRadius: 8)
//                )
//                .thumbSize(CGSize(width: 32, height: 32))
//
//                HorizontalRangeSlider(
//                    range: $model.range4,
//                    trackView: LinearGradient(gradient: Gradient(colors: [.green, .yellow, .red]), startPoint: .leading, endPoint: .trailing),
//                    thumbView: Capsule()
//                )
//                .thumbSize(CGSize(width: 16, height: 24))
//                .thickness(8)
//
//                HorizontalRangeSlider(
//                    range: $model.range6,
//                    trackView: HRangeTrack(
//                        range: $model.range6,
//                        valueView: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
//                    ),
//                    lowerThumbView: HalfCapsule(),
//                    upperThumbView: HalfCapsule().rotation(Angle(degrees: 180))
//                )
//                .thumbSize(CGSize(width: 26, height: 26))
//                .thickness(28)
//                .trackBorderColor(.gray)
//                .trackBorderWidth(1)
//
//                HorizontalRangeSlider(
//                    range: $model.range7,
//                    trackView: HorizontalRangeTrack(
//                        range: $model.range7,
//                        valueView: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .leading, endPoint: .trailing)
//                    )
//                )
//                .thumbSize(CGSize(width: 48, height: 24))
//                .thickness(8)
//
//                HorizontalRangeSlider(
//                    range: $model.range8,
//                    trackView: HorizontalRangeTrack(
//                        range: $model.range8,
//                        valueView: LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .leading, endPoint: .trailing),
//                        trackShape: RoundedRectangle(cornerRadius: 16)
//                    ),
//                    lowerThumbView: HalfCapsule(),
//                    upperThumbView: HalfCapsule().rotation(Angle(degrees: 180))
//                )
//                .height(72)
//                .thickness(64)
//                .thumbSize(CGSize(width: 32, height: 64))
//                .thumbBorderColor(Color.black.opacity(0.3))
//                .thumbBorderWidth(2)
//
//                HorizontalRangeSlider(
//                    range: $model.range9,
//                    trackView: HRangeTrack(
//                        range: $model.range9,
//                        valueView: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .leading, endPoint: .trailing),
//                        trackShape: Ellipse()
//                    )
//                )
//                .height(64)
//                .thickness(48)
//                .thumbSize(CGSize(width: 16, height: 56))
//                .trackBorderColor(Color.white.opacity(0.3))
//                .trackBorderWidth(2)
//
//                HorizontalRangeSlider(
//                    range: $model.range10,
//                    trackView:
//                        HRangeTrack(
//                            range: $model.range10,
//                            valueView:
//                            ZStack {
//                                LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
//                                VStack {
//                                    Text("Any View").font(.largeTitle).foregroundColor(.white)
//                                    Text("Place any view here and it will be masked to a selected value range").font(.title).foregroundColor(Color.white.opacity(0.5))
//                                }
//                            },
//                            trackShape: RoundedRectangle(cornerRadius: 10))
//                )
//                .height(128)
//                .thickness(128)
//                .thumbSize(CGSize(width: 8, height: 64))
            }
        }
        .padding()
        //.environment(\.isEnabled, false)
    }
}


struct HorizontalSliderExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalSliderExamplesView().environmentObject(Model.preview)
    }
}

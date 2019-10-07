import Foundation

final class Model: ObservableObject {
    var value = 0.5
    @Published var value1 = 0.5
    @Published var value2 = 0.5
    @Published var value3 = 0.5
    @Published var value4 = 0.5
    @Published var value5 = 0.5
    @Published var range1 = 0.1...0.9
    @Published var range2 = 0.1...0.9
    @Published var range3 = 0.1...0.9
    @Published var range4 = 0.1...0.9
    @Published var range5 = 0.1...0.9
    @Published var range6 = 0.1...0.9
    @Published var range7 = 0.1...0.9
    @Published var range8 = 0.1...0.9
    @Published var range9 = 0.1...0.9
    @Published var range10 = 0.3...0.7
    
    init() {}
}

extension Model {
    static let preview = Model()
}

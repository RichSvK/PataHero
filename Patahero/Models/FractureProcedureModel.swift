import SwiftData
import Foundation

@Model
class FractureProcedure: Identifiable {
    var id: UUID = UUID()
    var step: String
    var imagePath: String
    var order: Int
    
    @Relationship var fracture: Fracture?
    
    init(step: String, imagePath: String, order: Int) {
        self.step = step
        self.imagePath = imagePath
        self.order = order
    }
}

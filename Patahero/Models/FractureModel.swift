import SwiftData
import Foundation

@Model
class Fracture: Identifiable {
    var id: UUID = UUID()
    var name: String
    var imagePath: String
    var category: String
    
    // On Delete cascade
    @Relationship(deleteRule: .cascade)
    var procedure: [FractureProcedure] = []
    
    init(name: String, imagePath: String, category: String) {
        self.name = name
        self.imagePath = imagePath
        self.category = category
    }
}

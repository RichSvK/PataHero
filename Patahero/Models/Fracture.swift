import SwiftData
import Foundation

@Model
class Fracture: Identifiable {
    var id: UUID = UUID()
    var name: String
    var imagePath: String
    var fractureDescription: String
    var category: String
    var isFavorite: Bool = false
    
    // On Delete cascade
    @Relationship(deleteRule: .cascade)
    var procedure: [FractureProcedure] = []
    
    init(name: String, imagePath: String, description: String, category: String) {
        self.name = name
        self.imagePath = imagePath
        self.fractureDescription = description
        self.category = category
    }
}

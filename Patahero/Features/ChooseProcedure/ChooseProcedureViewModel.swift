import SwiftUI
import SwiftData

class ChooseProcedureViewModel: ObservableObject {
    @FocusState var isFocused: Bool
    
    @Published var fractures: [Fracture] = []
    @Published var categories: [String] = []
    @Published var selectedCategory: String = "Semua" {
        didSet{
            filterCategories()
        }
    }
    
    private var allFractures: [Fracture] = []
    private var hasLoadedCategories = false

    func loadCategories(with fracturesData: [Fracture]) {
        guard !hasLoadedCategories else { return }
        print("Loading categories data ...")

        self.allFractures = fracturesData.sorted {$0.priority < $1.priority}
        self.fractures = self.allFractures

        let unique = Set(fracturesData.map { $0.category })
        self.categories = ["Semua"] + unique.sorted()
        
        self.hasLoadedCategories = true
        print("Finished loaded categories data")
    }

    private func filterCategories(){
        print("Filtering data with category: \(selectedCategory)")
        
        if self.selectedCategory == "Semua" {
            self.fractures = allFractures
        } else {
            self.fractures = allFractures.filter { $0.category == selectedCategory }
        }
    }
}

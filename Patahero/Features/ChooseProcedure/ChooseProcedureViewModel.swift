import SwiftUI
import SwiftData

class ChooseProcedureViewModel: ObservableObject {
    @FocusState var isFocused: Bool
    
    private var allFractures: [Fracture] = []
    @Published var fractures: [Fracture] = []
    
    @Published var searchFractureText = "" {
        didSet {
            filterCategories()
        }
    }
    
    @Published var selectedCategory: String = "Semua" {
        didSet{
            filterCategories()
        }
    }
    @Published var categories: [String] = []
    
    private var hasLoadedCategories = false

    func loadCategories(with fracturesData: [Fracture]) {
        print("Loading categories data ...")
        guard !hasLoadedCategories else { return }
        
        self.allFractures = fracturesData
        self.fractures = fracturesData

        let unique = Set(fracturesData.map { $0.category })
        self.categories = ["Semua"] + unique.sorted()
        hasLoadedCategories = true
        print("Finished loaded categories data")
    }

    private func filterCategories(){
        print("Filtering data with category: \(selectedCategory) and filter: \(searchFractureText)")
        let searchedResult = searchFractureText.isEmpty ? self.allFractures : allFractures.filter {
            $0.name.localizedCaseInsensitiveContains(searchFractureText)
        }

        if self.selectedCategory == "Semua" {
            self.fractures = searchedResult
        } else {
            self.fractures = searchedResult.filter { $0.category == selectedCategory }
        }
        print("Finished searching data")
    }
}

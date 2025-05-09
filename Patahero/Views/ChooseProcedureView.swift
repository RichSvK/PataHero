import SwiftUI
import SwiftData

struct ChooseProcedureView: View{
    @FocusState private var isFocused: Bool

    @State var procedure = listFracture[0]
    @State var searchFractureText = ""
    @State var selectedCategory: String = "Semua"

    @Query private var fractures: [Fracture]

    var categories: [String] {
        let unique = Set(fractures.map { $0.category })
        return ["Semua"] + unique.sorted()
    }
        
    var filteredFractures: [Fracture] {
        let searchedResult = searchFractureText.isEmpty ? fractures : fractures.filter {$0.name.localizedCaseInsensitiveContains(searchFractureText)}
        
        if selectedCategory == "Semua" {
            return searchedResult
        } else {
            return searchedResult.filter { $0.category == selectedCategory }
        }
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View{
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Pilih panduan penanganan patah tulang")
                        .font(.title)
                        .lineLimit(2)
                        .dynamicTypeSize(.xSmall ... .xxLarge)
                        .padding(.bottom, 20)
                    
                    // Search bar
                    HStack{
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color("ColorText"))
                                
                            TextField("Cari jenis cedera", text: $searchFractureText)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                                .dynamicTypeSize(.xSmall ... .xxLarge)
                                .focused($isFocused)
                        }
                        .onTapGesture {
                            isFocused = true
                        }
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .textFieldStyle(PlainTextFieldStyle())
                        
                        Menu {
                            Button {
                                selectedCategory = "Semua"
                            } label: {
                                Label{
                                    Text("Semua")
                                } icon: {
                                    if selectedCategory == "Semua" {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                    } else {
                                        EmptyView()
                                    }
                                }
                            }
                            
                            Button {
                                selectedCategory = "Kaki"
                            } label: {
                                Label{
                                    Text("Kaki")
                                } icon: {
                                    if selectedCategory == "Kaki" {
                                        Image(systemName: "checkmark")
                                    } else {
                                        EmptyView()
                                    }
                                }
                            }
                            
                            Button {
                                selectedCategory = "Tangan"
                            } label: {
                                Label{
                                    Text("Tangan")
                                } icon: {
                                    if selectedCategory == "Tangan" {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                    } else {
                                        EmptyView()
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(10)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                        }
                    }
                    
                    // List panduan
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(filteredFractures) { item in
                            CardButton(
                                imageName: item.imagePath,
                                title: item.name,
                                destination: ProcedureView(fracture: item)
                            )
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .onTapGesture {
                isFocused = false
            }
        }
    }
}

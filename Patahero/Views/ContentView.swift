import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("hasSeededInitialData") private var hasSeededInitialData: Bool = false
    @FocusState private var isFocused: Bool

    @State var procedure = listFracture[0]
    @State var searchFractureText = ""
    @State var selectedCategory: String = "Semua"

    @Query private var fractures: [Fracture]

    var categories: [String] {
        let unique = Set(fractures.map { $0.category })
        return ["Semua"] + unique.sorted()
    }
    
    @Environment(\.modelContext) private var context

    
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
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Pilih panduan penanganan patah tulang")
                        .font(.title2)
                        .lineLimit(2)
                        .dynamicTypeSize(.xSmall ... .xxLarge)
                        .padding(.bottom, 20)
                    
                    HStack(spacing: 16) {
                        // Tombol Navigasi
                        NavigationLink(destination: MapView()) {
                            HStack {
                                Image(systemName: "map")
                                Text("Navigasi")
                                    .fontWeight(.semibold)
                            }
                            .font(.title2)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                            .dynamicTypeSize(.xSmall ... .xxLarge)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.blue)
                            .cornerRadius(12)
                        }

                        // Tombol Hubungi
                        Button(action: {
                            if let phoneURL = URL(string: "tel://08998106352"),
                               UIApplication.shared.canOpenURL(phoneURL) {
                                UIApplication.shared.open(phoneURL)
                            }
                        }) {
                            HStack {
                                Image(systemName: "phone.fill")
                                Text("Hubungi")
                                    .fontWeight(.semibold)
                            }
                            .font(.title2)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                            .dynamicTypeSize(.xSmall ... .xxLarge)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.red)
                            .cornerRadius(12)
                        }
                    }
                    .padding(.bottom, 10)

                    // Search bar
                    HStack{
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color("ColorText"))
                                .onTapGesture {
                                    isFocused = true
                                }

                            TextField("Cari jenis cedera", text: $searchFractureText)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                                .dynamicTypeSize(.xSmall ... .xxLarge)
                                .focused($isFocused)
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
                                destination: Procedure(fracture: item)
                            )
                        }
                    }
                    .padding()
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear {
            if !hasSeededInitialData {
                seedAppData(using: context)
            }
        }

    }
    
    private func seedAppData(using context: ModelContext) {
        let allProcedures = [armProcedure, fingerProcedure, wristProcedure, footProcedure]

        Task{
            for (index, fracture) in listFracture.enumerated() {
                if index < allProcedures.count {
                    for procedure in allProcedures[index] {
                        fracture.procedure.append(procedure)
                        procedure.fracture = fracture
                        context.insert(procedure)
                    }
                }
                context.insert(fracture)
            }
            
            do {
                try context.save()
                self.hasSeededInitialData = true
            } catch {
                print("Gagal menyimpan data awal: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
}

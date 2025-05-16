import SwiftUI
import SwiftData

struct ChooseProcedureView: View{
    @StateObject var viewModel: ChooseProcedureViewModel = ChooseProcedureViewModel()
    @FocusState private var isFocused: Bool
    @Query private var fracturesData: [Fracture]
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View{
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("Pilih panduan penanganan patah tulang")
                    .font(.system(size: 20, weight: .bold))
                    .lineLimit(2)
                    .dynamicTypeSize(.xSmall ... .xxLarge)
                
                // Filter kategori
                Picker("Kategori", selection: $viewModel.selectedCategory) {
                    ForEach(viewModel.categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical, 10)
                
                // List panduan
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.fractures) { item in
                        NavigationLink {
                            ProcedureView(viewModel: ProcedureViewModel(fracture: item))
                                .navigationTitle(item.name)
                                .navigationBarTitleDisplayMode(.inline)
                        } label: {
                            CardButton(
                                imageName: item.imagePath,
                                title: item.name
                            )
                        }
                    }
                }
                Spacer()
            }
        }
        .onAppear{
            viewModel.loadCategories(with: fracturesData)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .background(Color("ColorBackground"))
        .onTapGesture {
            isFocused = false
        }
    }
}

#Preview {
   ChooseProcedureView()
}
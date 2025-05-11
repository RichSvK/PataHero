import SwiftUI
import SwiftData

struct ChooseProcedureView: View{
    @StateObject var viewModel: ChooseProcedureViewModel
    @FocusState private var isFocused: Bool
    @Query private var fracturesData: [Fracture]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View{
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
                            
                        TextField("Cari jenis cedera", text: $viewModel.searchFractureText)
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
                        ForEach(viewModel.categories, id: \.self){ category in
                            Button {
                                viewModel.selectedCategory = category
                            } label: {
                                Label{
                                    Text(category)
                                } icon: {
                                    if viewModel.selectedCategory == category {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                    } else {
                                        EmptyView()
                                    }
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
                    ForEach(viewModel.fractures) { item in
                        NavigationLink(destination: ProcedureView(viewModel: ProcedureViewModel(fracture: item))){
                            CardButton(
                                imageName: item.imagePath,
                                title: item.name
                            )
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .onAppear{
            viewModel.loadCategories(with: fracturesData)
        }
        .onTapGesture {
            isFocused = false
        }
    }
}

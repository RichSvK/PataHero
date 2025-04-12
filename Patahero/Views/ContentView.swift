import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("hasSeededInitialData") private var hasSeededInitialData: Bool = false

    @State var procedure = listFracture[0]
    @State var searchFractureText = ""
    
    @Environment(\.modelContext) private var context

    @Query private var fractures: [Fracture]
    
    var filteredFractures: [Fracture] {
        if searchFractureText.isEmpty {
            return fractures
        } else {
            return fractures.filter { $0.name.localizedCaseInsensitiveContains(searchFractureText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Butuh Panduan?")
                    .font(.title)
                    .fontWeight(.bold)
                    .dynamicTypeSize(.medium ... .xxLarge)
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
                                        
                Text("Pilih panduan penanganan patah tulang")
                    .font(.title2)
                    .dynamicTypeSize(.medium ... .xxLarge)
                    .minimumScaleFactor(0.8)
                    .padding(.bottom, 20)
                    .lineLimit(2)
                
                TextField("Cari jenis cedera", text: $searchFractureText)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 10)
                
                // List panduan
                VStack(spacing: 20) {
                    ForEach(filteredFractures) { item in
                        CardButton(
                            imageName: item.imagePath,
                            title: item.name,
                            destination: Procedure(fracture: item)
                        )
                    }
                }
                
                Spacer()
                
                // Navigasi ke MapView
                NavigationLink(destination: MapView()) {
                    Text("Navigasi ke Eka Hospital")
                        .font(.title3)
                        .foregroundColor(.blue)
                        .dynamicTypeSize(.medium ... .xxLarge)
                        .minimumScaleFactor(0.8)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, minHeight: 0)
                }
                
                CallButton()
                    .padding(.bottom)
            }
            .padding(.horizontal, 20)
        }
        .onAppear {
            if !hasSeededInitialData {
                seedAppData(using: context)
            }
        }
    }
    
    private func seedAppData(using context: ModelContext) {
        var procedureIndex = 0
        Task{
            
            for fracture in listFracture {
                switch procedureIndex {
                case 0:
                    for procedure in armProcedure {
                        fracture.procedure.append(procedure)
                        procedure.fracture = fracture
                        context.insert(procedure)
                    }
                case 1:
                    for procedure in fingerProcedure {
                        fracture.procedure.append(procedure)
                        procedure.fracture = fracture
                    }
                case 2:
                    for procedure in wristProcedure {
                        fracture.procedure.append(procedure)
                        procedure.fracture = fracture
                    }
                default:
                    break
                }

                context.insert(fracture)
                
                procedureIndex += 1
            }
        }
        
        do {
            try context.save()
            self.hasSeededInitialData = true
        } catch {
            print("Gagal menyimpan data awal: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}

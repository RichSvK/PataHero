import SwiftUI

struct ContentView: View {
    @State var procedure = listFracture[0]
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                Text("Butuh Panduan?")
                    .font(.title)
                    .fontWeight(.bold)
                    .dynamicTypeSize(.medium ... .xxLarge)
                    .minimumScaleFactor(0.8)
                    .padding(.horizontal, 20)
                    .lineLimit(1)
                                        
                Text("Pilih panduan penanganan patah tulang")
                    .font(.title2)
                    .dynamicTypeSize(.medium ... .xxLarge)
                    .minimumScaleFactor(0.8)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    .lineLimit(2)
                
                // Menu Buttons
                VStack(spacing: 10) {
                    VStack (spacing: 20){
                        ForEach(listFracture){ item in
                            CardButton(imageName: item.imagePath, title: item.name, destination: Procedure(fracture: item, fractureProcedure: item.id == 1 ? armProcedure : (item.id == 2 ? fingerProcedure : wristProcedure)))
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    CallButton().padding(.bottom)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

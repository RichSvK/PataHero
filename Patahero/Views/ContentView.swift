import SwiftUI

struct ContentView: View {
    @State var procedure = listFracture[0]
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                Text("Butuh Panduan?")
                    .font(.system(size: adaptiveFontSize(for: UIScreen.main.bounds.width, baseSize: 25)))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .dynamicTypeSize(.medium ... .xxLarge)
                    .minimumScaleFactor(0.8)
                    .padding(.horizontal, 20)
                    .lineLimit(1)
                                        
                Text("Pilih jenis patah tulang untuk penanganan pertolongan pertama")
                    .font(.system(size: adaptiveFontSize(for: UIScreen.main.bounds.width * 0.6, baseSize: 20)))
                    .foregroundColor(.black)
                    .dynamicTypeSize(.medium ... .large)
                    .minimumScaleFactor(0.6)
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
                    
                    // Call Button
                    CallButton()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

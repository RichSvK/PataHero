import SwiftUI

struct ContentView: View {
    @State var procedure = listFracture[0]
    
    var body: some View {
        NavigationView {
            VStack {
                // Menu Buttons
                VStack(spacing: 30) {
                    VStack{
                        
                        Text("Butuh Panduan? Pilih Cedera")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .dynamicTypeSize(.medium ... .xxLarge)
                            .minimumScaleFactor(0.8)
                        
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
//        .environment(\.sizeCategory, .large)
    }
}

// Fungsi untuk ukuran teks responsif
func adaptiveFontSize(for width: CGFloat, baseSize: CGFloat) -> CGFloat {
    return max(baseSize * (width / 390), baseSize * 0.8)
}

// Konversi Warna Hex ke Color SwiftUI
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    ContentView()
}

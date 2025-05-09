import SwiftUI

struct HospitalView: View{
    
    var body: some View{
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
    }
}

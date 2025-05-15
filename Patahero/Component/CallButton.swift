import SwiftUI

struct CallButton: View {
    @State private var showCallAlert: Bool = false
    private let phoneNumber: String = "081360986278"
    
    var body: some View {
        Button(action: {
            if let phoneURL = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(phoneURL){
                UIApplication.shared.open(phoneURL)
                showCallAlert = false
            } else {
                showCallAlert = true
            }
        }) {
            HStack {
                Image(systemName: "phone.fill")
                    .font(.title2)
                    .dynamicTypeSize(.medium ... .xxLarge)
                
                Text("Hubungi Eka Hospital")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .dynamicTypeSize(.medium ... .xxLarge)
                    .minimumScaleFactor(0.8)
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(Color(.red))
        .cornerRadius(10)
        .padding(.top)
        .alert("Error", isPresented: $showCallAlert){
            Button("Silahkan coba lagi") {
                showCallAlert = false
            }
        } message: {
            Text("Gagal menghubungi Eka Hospital.")
        }
    }
}

#Preview {
    CallButton()
}

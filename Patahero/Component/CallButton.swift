import SwiftUI

struct CallButton: View {
    @State private var showCallAlert: Bool = false
    private let phoneNumber: String = "081360986278"
    
    var body: some View {
        Button(action: {
            makePhoneCall()
        }) {
            HStack {
                Image(systemName: "phone.fill")
                    .font(.title2)
                    .dynamicTypeSize(.medium ... .xxLarge)
                
                Text("Hubungi Eka Hospital")
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(Color(.red))
        .cornerRadius(10)
        .alert("Error", isPresented: $showCallAlert){
            Button("Silahkan coba lagi") {
                showCallAlert = false
            }
        } message: {
            Text("Gagal menghubungi Eka Hospital.")
        }
    }
    
    private func makePhoneCall() {
        if let phoneURL = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(phoneURL){
            UIApplication.shared.open(phoneURL)
            showCallAlert = false
        } else {
            showCallAlert = true
        }
    }
}

#Preview {
    CallButton()
}

import SwiftUI

struct CallButton: View{
    @State private var showCallAlert: Bool = false
    
    var body: some View {
        Button(action: {
            if let phoneURL = URL(string: "tel://08998106352"), UIApplication.shared.canOpenURL(phoneURL){
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
                    .dynamicTypeSize(.medium ... .xxLarge)
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(Color(red: 241 / 255, green: 76 / 255, blue: 66 / 255))
        .cornerRadius(40)
        .padding(.top)
        .alert("Error", isPresented: $showCallAlert){
            Button("Ok") {
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

import SwiftUI

struct SwipeTutorialView: View {
    @State private var offsetX: CGFloat = 30
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "hand.draw.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
                .scaleEffect(x: -1, y: 1)
                .offset(x: offsetX)
                .animation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true), value: offsetX)

            Text("Geser untuk berpindah langkah prosedur")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Spacer()

            Text("Klik layar untuk menutup tutorial")
                .font(.system(size: 16, weight: .semibold))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 20)
            Spacer()
        }
        .padding()
        .onAppear {
            startAnimation()
        }
    }
    
    // Fungsi untuk memulai animasi
    private func startAnimation() {
        withAnimation {
            offsetX = -30
        }
    }
}

struct tempView: View{
    var body: some View{
        ZStack{
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            SwipeTutorialView()
        }
    }
}

#Preview {
//    SwipeTutorialView()
    tempView()
}

import SwiftUI
import MapKit

struct HospitalView: View {
    @StateObject private var viewModel = HospitalViewModel()    
    
    var body: some View {
        VStack {
            if viewModel.userLocationReady || viewModel.route != nil {
                ZStack {
                    Map(position: $viewModel.cameraPosition) {
                        Marker("Eka Hospital", systemImage: "plus.square.fill", coordinate: viewModel.hospitalLocation)

                        UserAnnotation()
                        
                        if let route = viewModel.route {
                            MapPolyline(route.polyline)
                                .stroke(Color.blue, lineWidth: 5)
                        }
                    }
                    .mapStyle(.standard)
                    .safeAreaInset(edge: .top) {
                        Spacer().frame(height: 40)
                    }
                    .safeAreaInset(edge: .trailing) {
                        Spacer().frame(width: 30)
                    }
                    .ignoresSafeArea()
                    .mapControls{
                        MapCompass()
                        MapScaleView()
                        MapUserLocationButton()
                    }

                    VStack {
                        Spacer()
                        
                        VStack {
                            Spacer()
                            Button(action: viewModel.makePhoneCall) {
                                Label("Hubungi Eka Hospital", systemImage: "phone.fill")
                                    .font(.title2)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.red)
                                    .cornerRadius(8)
                            }
                            .padding()
                            .alert("Tidak dapat melakukan panggilan", isPresented: $viewModel.showCallAlert) {
                                Button("OK", role: .cancel) {}
                            } message: {
                                Text("Perangkat Anda tidak mendukung panggilan telepon atau nomor tidak valid.")
                            }
                        }
                    }
                }
            } else {
                ProgressView("Menunggu Lokasi Pengguna...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
        }
    }
}

import SwiftUI
import MapKit

struct HospitalView: View {
    @StateObject private var viewModel: HospitalViewModel = HospitalViewModel()
    
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
                        Spacer().frame(height: 65)
                    }
                    .safeAreaInset(edge: .trailing) {
                        Spacer().frame(width: 30)
                    }
                    .ignoresSafeArea()
                    .mapControls{
                        MapUserLocationButton()
                        MapCompass()
                        MapScaleView()
                    }

                    VStack {
                        Spacer()
                        
                        CallButton()
                            .padding(.all, 20)
                    }
                }
            } else {
                ProgressView("Menunggu Lokasi Pengguna...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }           
        }
        .onDisappear{
            viewModel.cleanUp()
        }
        .onAppear {
            viewModel.start()
        }
    }
}

#Preview{
    HospitalView()
}

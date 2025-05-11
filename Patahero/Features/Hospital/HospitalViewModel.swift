import SwiftUI
import MapKit
import Combine

class HospitalViewModel: ObservableObject {
    @Published var cameraPosition: MapCameraPosition = .automatic
    @Published var route: MKRoute?
    @Published var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @Published var userLocationReady: Bool = false
    @Published var mapView = MKMapView()
    @Published var locationManager = LocationManager()

    let hospitalLocation = CLLocationCoordinate2D(latitude: -6.298920889533608, longitude: 106.66991187639381)
    private var cancellables = Set<AnyCancellable>()

    init() {
        locationManager.$userLocation
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newLocation in
                self?.userLocation = newLocation
                self?.userLocationReady = true
            }
            .store(in: &cancellables)
    }

    func requestRoute() {
        guard userLocationReady else {
            print("Lokasi pengguna belum tersedia atau tidak valid")
            return
        }

        print("Menghitung rute dari \(userLocation) ke \(hospitalLocation)")

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: hospitalLocation))
        request.transportType = .walking

        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            if let route = response?.routes.first {
                DispatchQueue.main.async {
                    self?.route = route
                    print("Rute ditemukan. Jarak: \(route.distance) meter")
                }
            } else if let error = error {
                print("Gagal menghitung rute: \(error.localizedDescription)")
            } else {
                print("Tidak ada rute ditemukan dan tidak ada error")
            }
        }
    }
}

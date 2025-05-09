import SwiftUI
import MapKit
import CoreLocation

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager?
    private var hasSetInitialRegion = false

    var userLocation: CLLocationCoordinate2D?
    var region: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    func start() {
        if CLLocationManager.locationServicesEnabled() {
           locationManager = CLLocationManager()
            locationManager?.delegate = self
        } else {
            print("Berikan izin akses lokasi pada Settings")
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()

            case .authorizedWhenInUse, .authorizedAlways:
                manager.startUpdatingLocation()

            case .restricted, .denied:
                print("Akses lokasi ditolak")

            @unknown default:
                break
        }
    }

    private func updateRegion(to coordinate: CLLocationCoordinate2D) {
        self.userLocation = coordinate
        self.region = .region(
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        )
    }

    // Callback saat lokasi diperbarui
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else { return }

        self.userLocation = coordinate

        if !hasSetInitialRegion {
            updateRegion(to: coordinate)
            hasSetInitialRegion = true
        }
    }
}

//
//  LocationManager.swift
//  SalahKit
//
//  Created by Khalil Sabirov on 19.10.2024.
//

import CoreLocation
import Combine
import SwiftData
import SwiftUI

final class LocationManager: NSObject, ObservableObject {
    
    @Published var location: CLLocation?
    @Published var address: Address = .init(city: nil, street: nil)
    
    private let modelContext: ModelContext
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    private var cancellable: AnyCancellable?
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        
        super.init()
        
        cancellable = $location.sink { [unowned self] location in
            guard let location else { return }
            getAddress(from: location) { address in
                if address.isValid {
                    self.address = address
                } else {
                    let latitude = String(format: "%.4f", location.coordinate.latitude)
                    let longitude = String(format: "%.4f", location.coordinate.longitude)
                    self.address = .init(city: nil, street: "\(latitude), \(longitude)")
                }
            }
        }
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.requestWhenInUseAuthorization()
    }
    
//    override init() {
//        super.init()
//        
//        cancellable = $location.sink { [unowned self] location in
//            guard let location else { return }
//            getAddress(from: location) { address in
//                if address.isValid {
//                    self.address = address
//                } else {
//                    let latitude = String(format: "%.4f", location.coordinate.latitude)
//                    let longitude = String(format: "%.4f", location.coordinate.longitude)
//                    self.address = .init(city: nil, street: "\(latitude), \(longitude)")
//                }
//            }
//        }
//        
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
//        manager.requestWhenInUseAuthorization()
//    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
//    func fetchLastLocation(completion: @escaping (UserLocationModel?) -> Void) {
//        DispatchQueue.global(qos: .background).async {
//            let descriptor = FetchDescriptor<UserLocationModel>(sortBy: [SortDescriptor(\.date, order: .reverse)])
//            do {
//                let locations = try self.modelContext.fetch(descriptor)
//                print(locations.count)
//                DispatchQueue.main.async {
//                    completion(locations.first)
//                }
//            } catch {
//                print("Error fetching user locations: \(error)")
//                DispatchQueue.main.async {
//                    completion(nil)
//                }
//            }
//        }
//    }
    
    func fetchUserLocation() async throws -> UserLocationModel? {
        do {
            let descriptor = FetchDescriptor<UserLocationModel>(sortBy: [SortDescriptor(\.date, order: .reverse)])
            let locations = try await modelContext.
            return locations.first
        } catch {
            print("Error fetching data: \(error)")
            return nil
        }
    }
}

// MARK: - Helpers

private extension LocationManager {
    func getAddress(from location: CLLocation, completion: @escaping (Address) -> Void) {
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard error == nil, let placemark = placemarks?.first else {
                print("Reverse geocoding error: \(error!)")
                completion(.init(city: nil, street: nil))
                return
            }
            completion(.init(city: placemark.locality, street: placemark.thoroughfare))
        }
    }

}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.location = location
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                manager.requestLocation()
            default:
                print("locationManagerDidChangeAuthorization \(manager.authorizationStatus)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("locationManager didFailWithError: \(error)")
    }
}

// MARK: - Address

extension LocationManager {
    struct Address: Codable {
        let city: String?
        let street: String?
        
        var isValid: Bool {
            city != nil || street != nil
        }
    }
}

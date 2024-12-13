//
//  UserLocationModel.swift
//  SalahKit
//
//  Created by Khalil Sabirov on 09.12.2024.
//

import Foundation
import SwiftData
import CoreLocation

@Model
final class UserLocationModel: Identifiable {
    @Attribute(.unique)
    var id: UUID
    @Attribute(.unique)
    var address: LocationManager.Address
    @Attribute(.unique)
    var location: CLLocationCoordinate2D
    @Attribute(.unique)
    var date: Date
    
    init(address: LocationManager.Address, location: CLLocationCoordinate2D) {
        self.id = UUID()
        self.address = address
        self.location = location
        self.date = .now
    }
}

extension CLLocationCoordinate2D: Codable {
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        self.init(latitude: latitude, longitude: longitude)
    }
}

final class UserLocationModelDTO: Sendable, Identifiable {
    let id: UUID
    let address: LocationManager.Address
    let location: CLLocationCoordinate2D
    let date: Date
    
    init(
        id: UUID,
        address: LocationManager.Address,
        location: CLLocationCoordinate2D,
        date: Date
    ) {
        self.id = id
        self.address = address
        self.location = location
        self.date = date
    }
}

@ModelActor
actor UserLocationModelBackgroundActor {
    private var context: ModelContext { modelExecutor.modelContext }
    
    func fetchData() async throws -> [UserLocationModelDTO] {
        let fetchDescriptor = FetchDescriptor<UserLocationModel>(sortBy: [SortDescriptor(\.date)])
        let locations: [UserLocationModel] = try context.fetch(fetchDescriptor)
        let locationDTOs = locations.map{
            UserLocationModelDTO(
                id: $0.id,
                address: $0.address,
                location: $0.location,
                date: $0.date
            )
        }
        return locationDTOs
    }
}

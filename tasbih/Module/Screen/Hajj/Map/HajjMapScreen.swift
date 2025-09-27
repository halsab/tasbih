//
//  HajjMapScreen.swift
//  tasbih
//
//  Created by Khalil Sabirov on 23.09.2025.
//

import SwiftUI
import MapKit

struct HajjMapScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 21.4225, longitude: 39.8262), // Al-Haram
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    )
    
    var body: some View {
        Map(position: $cameraPosition) {
            
        }
        .mapStyle(.hybrid)
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
            MapPitchToggle()
        }
        .overlay(alignment: .bottomTrailing) {
            Button("Close") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle)
            .padding()
        }
        .toolbar(.hidden)
    }
}

#Preview {
    HajjMapScreen()
}

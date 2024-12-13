//
//  LocationPickerView.swift
//  SalahKit
//
//  Created by Khalil Sabirov on 10.12.2024.
//

import SwiftUI
import MapKit

struct LocationPickerView: View {
    
    @ObservedObject private var vm: PrayerTimesViewModel
    @State private var position = MapCameraPosition.automatic
    @State private var searchResults = [SearchResult]()
    @State private var isSheetPresented: Bool = true
    
    init(vm: PrayerTimesViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        NavigationStack {
            Map(position: $position, selection: $vm.selectedLocation) {
                ForEach(searchResults) { result in
                    Marker(coordinate: result.location.coordinate) {
                        Image(systemName: "mappin")
                    }
                    .tag(result)
                }
            }
            .navigationTitle("Select location")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea()
            .onChange(of: vm.selectedLocation) {
                isSheetPresented = vm.selectedLocation == nil
            }
            .onChange(of: searchResults) {
                if let firstResult = searchResults.first, searchResults.count == 1 {
                    vm.selectedLocation = firstResult
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                SheetView(searchResults: $searchResults)
            }
        }
    }
}

#Preview {
    LocationPickerView(vm: PrayerTimesViewModel())
}

struct SheetView: View {
    @State private var locationService = LocationService(completer: .init())
    @State private var search: String = ""
    // 1
    @Binding var searchResults: [SearchResult]
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $search)
                    .autocorrectionDisabled()
                // 2
                    .onSubmit {
                        Task {
                            searchResults = (try? await locationService.search(with: search)) ?? []
                        }
                    }
            }
            .modifier(TextFieldGrayBackgroundColor())
            
            Spacer()
            
            List {
                ForEach(locationService.completions) { completion in
                    // 3
                    Button(action: { didTapOnCompletion(completion) }) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(completion.title)
                                .font(.headline)
                                .fontDesign(.rounded)
                            Text(completion.subTitle)
                            // What can we show?
                            if let url = completion.url {
                                Link(url.absoluteString, destination: url)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .onChange(of: search) {
            locationService.update(queryFragment: search)
        }
        .padding()
        .interactiveDismissDisabled()
        .presentationDetents([.height(200), .large])
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
    }
    
    // 4
    private func didTapOnCompletion(_ completion: SearchCompletions) {
        Task {
            if let singleLocation = try? await locationService.search(with: "\(completion.title) \(completion.subTitle)").first {
                searchResults = [singleLocation]
            }
        }
    }
}

struct TextFieldGrayBackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(.gray.opacity(0.1))
            .cornerRadius(8)
            .foregroundColor(.primary)
    }
}

struct SearchResult: Identifiable, Hashable {
    let id = UUID()
    let location: CLLocation
    
    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct SearchCompletions: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
    // New property to hold the URL if it exists
    var url: URL?
}

@Observable
class LocationService: NSObject, MKLocalSearchCompleterDelegate {
    private let completer: MKLocalSearchCompleter
    
    var completions = [SearchCompletions]()
    
    init(completer: MKLocalSearchCompleter) {
        self.completer = completer
        super.init()
        self.completer.delegate = self
    }
    
    func update(queryFragment: String) {
        completer.resultTypes = .address
        completer.queryFragment = queryFragment
    }
    
    @MainActor
    func search(with query: String, coordinate: CLLocationCoordinate2D? = nil) async throws -> [SearchResult] {
        return try await withCheckedThrowingContinuation { continuation in
            Task.detached { // Or Task { @MainActor in ... } if updates are needed during search
                let mapKitRequest = MKLocalSearch.Request()
                mapKitRequest.naturalLanguageQuery = query
                mapKitRequest.resultTypes = .pointOfInterest
                if let coordinate {
                    mapKitRequest.region = .init(.init(origin: .init(coordinate), size: .init(width: 1, height: 1))) // Region for better results
                }
                let search = MKLocalSearch(request: mapKitRequest)
                
                search.start { response, error in
                    if let error {
                        continuation.resume(throwing: error)
                    } else if let response {
                        let results = response.mapItems.compactMap { mapItem -> SearchResult? in
                            guard let location = mapItem.placemark.location else { return nil }
                            return SearchResult(location: location)
                        }
                        continuation.resume(returning: results)
                    } else {
                        continuation.resume(throwing: NSError(domain: "SearchErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unexpected nil response"]))
                    }
                }
            }
        }
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completions = completer.results.map { completion in
            // Get the private _mapItem property
            let mapItem = completion.value(forKey: "_mapItem") as? MKMapItem
            
            return .init(
                title: completion.title,
                subTitle: completion.subtitle,
                url: mapItem?.url
            )
        }
    }
}

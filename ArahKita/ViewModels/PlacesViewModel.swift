//
//  PlacesViewModel.swift
//  ArahKita
//
//  Created by Tomi Mandala Putra on 15/05/2025.
//

import CoreLocation
import Foundation

@MainActor
class PlacesViewModel: NSObject, ObservableObject {
    private let apiClient = APIClient()
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?

    @Published var selectedKeyword: Keyword = .cafe
    @Published var places: [PlaceRowModel] = []
    @Published var isLoading: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func changeKeyword(to keyword: Keyword) async {
        guard let currentLocation = currentLocation else { return }

        if selectedKeyword == keyword { return }
        else { selectedKeyword = keyword }

        await fetchPlaces(location: currentLocation)
    }

    func fetchPlaces(location: CLLocation) async {
        isLoading = true
        let result = await apiClient.getPlaces(forKeyword: selectedKeyword.apiName, location: location)
        isLoading = false
        parseAPIResult(result: result)
    }

    private func parseAPIResult(result: APIClient.PlacesResult) {
        switch result {
        case .success(let placesResponseModel):
            let data = placesResponseModel.results
            places = data.compactMap { PlaceRowModel(place: $0) }
        case .failure(let placeError):
            switch placeError {
            case .invalidURL, .invalidResponse, .badRequestError:
                alertTitle = "Something has gone wrong"
                alertMessage = "We apologize and we are looking into the issue. Please try again later."
            case .serverError:
                alertTitle = "Something has gone wrong"
                alertMessage = "Please check your internet connection or please try again later."
            }
            showAlert = true
        }
    }
}

extension PlacesViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {}

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied, .restricted:
            alertTitle = "No location access"
            alertMessage = "Please grant location access in settings to allow ArahKita to find places around you."
            showAlert = true
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            alertTitle = "No location access"
            alertMessage = "Please grant location access in settings to allow ArahKita to find places around you."
            showAlert = true
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        currentLocation = location
        Task {
            await fetchPlaces(location: location)
        }
    }
}

//
//  APIClient.swift
//  ArahKita
//
//  Created by Tomi Mandala Putra on 15/05/2025.
//

import CoreLocation
import Foundation

class APIClient {
    private let baseURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    private let googlePlaceKey = "GOOGLE_PLACE_KEY"

    typealias PlacesResult = Result<PlacesResponseModel, PlacesErrorModel>

    private func responseType(statusCode: Int) -> ResponseTypeModel {
        switch statusCode {
        case 100 ..< 200:
            print("DEBUG: Informational response")
            return .informational
        case 200 ..< 300:
            print("DEBUG: Successful request")
            return .success
        case 300 ..< 400:
            print("DEBUG: Redirection")
            return .redirection
        case 400 ..< 500:
            print("DEBUG: Error client")
            return .clientError
        case 500 ..< 600:
            print("DEBUG: Error server")
            return .serverError
        default:
            print("DEBUG: Unknown status code")
            return .undefined
        }
    }

    private func createURL(location: CLLocation, keyword: String) -> URL? {
        var urlComponents = URLComponents(string: baseURL)
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "location", value: "\(location.coordinate.latitude),\(location.coordinate.longitude)"),
            URLQueryItem(name: "rankby", value: "distance"),
            URLQueryItem(name: "keyword", value: keyword),
            URLQueryItem(name: "key", value: googlePlaceKey)
        ]

        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }

    func getPlaces(forKeyword keyword: String, location: CLLocation) async -> PlacesResult {
        guard let url = createURL(location: location, keyword: keyword) else {
            return .failure(.invalidURL)
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }

            let responseType = responseType(statusCode: response.statusCode)

            switch responseType {
            case .serverError, .informational, .redirection, .undefined:
                print("DEBUG: Server error in request")
                return .failure(.serverError)

            case .clientError:
                print("Error in request")
                return .failure(.badRequestError)

            case .success:
                let decodeJSON = try JSONDecoder().decode(PlacesResponseModel.self, from: data)
                // print(decodeJSON)
                return .success(decodeJSON)
            }
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            return .failure(.badRequestError)
        }
    }
}

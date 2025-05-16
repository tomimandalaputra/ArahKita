//
//  PlacesResponseModel.swift
//  ArahKita
//
//  Created by Tomi Mandala Putra on 15/05/2025.
//

import Foundation

struct PlacesResponseModel: Decodable {
    let results: [PlaceDetailResponseModel]
}

struct PlaceDetailResponseModel: Decodable {
    let placeId: String
    let name: String
    let photos: [PhotoInfo]?
    let rating: Double
    let vicinity: String
    let userRatingsTotal: Int

    // MARK: - Refence to keys on response JSON

    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case name
        case photos
        case rating
        case vicinity
        case userRatingsTotal = "user_ratings_total"
    }
}

struct PhotoInfo: Decodable {
    let photoReference: String

    // MARK: - Refence to keys on response JSON

    enum CodingKeys: String, CodingKey {
        case photoReference = "photo_reference"
    }
}

//
//  PlaceRowModel.swift
//  ArahKita
//
//  Created by Tomi Mandala Putra on 15/05/2025.
//

import Foundation

struct PlaceRowModel: Identifiable {
    let id: String
    let name: String
    let photoURL: URL
    let rating: Double
    let address: String
    let userRatingsTotal: Int

    init?(place: PlaceDetailResponseModel) {
        self.id = place.placeId
        self.name = place.name
        self.rating = place.rating
        self.address = place.vicinity
        self.userRatingsTotal = place.userRatingsTotal

        guard let photos = place.photos,
              let firstPhoto = photos.first,
              let photoURL = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=\(firstPhoto.photoReference)&key=GOOGLE_PLACE_KEY")
        else {
            return nil
        }
        self.photoURL = photoURL
    }
}

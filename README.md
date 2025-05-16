# ArahKita

**ArahKita** adalah aplikasi iOS berbasis SwiftUI yang memungkinkan pengguna menemukan tempat terdekat berdasarkan lokasi mereka secara real-time. Aplikasi ini terintegrasi dengan Google Places API untuk memberikan hasil pencarian lokasi yang akurat dan informatif.

## ✨ Fitur Utama

- 📍 Deteksi lokasi pengguna secara real-time
- 🔍 Pencarian tempat terdekat berdasarkan kategori (restoran, kafe, SPBU, ATM, SPA, GYM, dll)
- 📝 Menampilkan list tempat seperti nama, rating, alamat, dan jarak dari lokasi pengguna

## 🛠️ Teknologi yang Digunakan
- [Swift](https://swift.org/)
- [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- [Google Maps SDK for iOS](https://developers.google.com/maps/documentation/ios-sdk/overview)
- [Google Places API for iOS](https://developers.google.com/maps/documentation/places/ios-sdk/overview)
- CoreLocation

## 🚀 Cara Menjalankan Proyek

### 1. Clone Repository
```bash
git clone https://github.com/tomimandalaputra/ArahKita.git
cd arahkita

// Masukan GOOGLE_PLACE_KEY kalian pada file berikut:

// @/Client/APIClient.swift
class APIClient {
    private let baseURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    private let googlePlaceKey = "GOOGLE_PLACE_KEY"
    ...
}

// @/Models/PlaceRowModel.swift
struct PlaceRowModel: Identifiable {
    ...

    init?(place: PlaceDetailResponseModel) {
        ...
        guard let photos = place.photos,
              let firstPhoto = photos.first,
              let photoURL = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=\(firstPhoto.photoReference)&key=GOOGLE_PLACE_KEY")
        else {
            return nil
        }
        ...
    }
}

```

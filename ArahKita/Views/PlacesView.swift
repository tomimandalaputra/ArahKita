//
//  PlacesView.swift
//  ArahKita
//
//  Created by Tomi Mandala Putra on 15/05/2025.
//

import MapKit
import SwiftUI

struct PlacesView: View {
    @StateObject private var viewModel = PlacesViewModel()

    private var HorizontalList: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 4) {
                ForEach(Keyword.allCases) { keyword in
                    Button(action: {
                        Task {
                            await viewModel.changeKeyword(to: keyword)
                        }
                    }, label: {
                        Text(keyword.title)
                            .font(.system(
                                size: 14,
                                weight: viewModel.selectedKeyword == keyword ? .medium : .regular)
                            )
                            .foregroundStyle(Color.black)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)

                    })
                    .background(viewModel.selectedKeyword == keyword ? Color.gray.opacity(0.2) : Color.clear)
                    .clipShape(Capsule())
                }
            }
            .padding(.horizontal)
            .frame(height: 62)
        }
    }

    private func PlaceRow(place: PlaceRowModel) -> some View {
        HStack {
            AsyncImage(url: place.photoURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } placeholder: {
                ProgressView()
                    .frame(width: 50, height: 50)
            }
            VStack(alignment: .leading) {
                Text(place.name)
                    .font(.system(size: 15, weight: .semibold))
                Text(place.address)
                    .font(.system(size: 14))
                Text("Total ratings: \(place.userRatingsTotal)")
                    .foregroundStyle(Color.gray)
                    .font(.system(size: 14))
            }
            Spacer()
            HStack {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                Text("\(Int(place.rating))")
                    .font(.system(size: 14))
            }
        }
    }

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack {
                HorizontalList

                List {
                    ForEach(viewModel.places) { place in
                        PlaceRow(place: place)
                    }
                }

                Spacer()
            }
            .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
                Button("OK", action: {})
            } message: {
                Text(viewModel.alertMessage)
            }

            if viewModel.isLoading {
                Color.black.opacity(0.5).ignoresSafeArea()
                ProgressView().tint(Color.white)
            }
        }
    }
}

#Preview {
    PlacesView()
}

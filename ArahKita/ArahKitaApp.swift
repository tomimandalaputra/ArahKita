//
//  ArahKitaApp.swift
//  ArahKita
//
//  Created by Tomi Mandala Putra on 15/05/2025.
//

import SwiftUI

@main
struct ArahKitaApp: App {
    @State private var showSplashView = true

    var body: some Scene {
        WindowGroup {
            Group {
                if showSplashView {
                    SplashView().transition(.opacity)
                } else {
                    PlacesView().transition(.move(edge: .bottom))
                }
            }
            .preferredColorScheme(.light)
            .animation(.easeInOut(duration: 0.5), value: showSplashView)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        showSplashView = false
                    }
                }
            }
        }
    }
}

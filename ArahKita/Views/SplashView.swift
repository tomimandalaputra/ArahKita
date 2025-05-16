//
//  SplashView.swift
//  ArahKita
//
//  Created by Tomi Mandala Putra on 15/05/2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 12) {
                Spacer()

                HStack {
                    Circle()
                        .foregroundStyle(Color.cyan.opacity(0.75))
                        .frame(width: 32, height: 32)

                    Rectangle()
                        .foregroundStyle(Color.teal.opacity(0.75))
                        .frame(width: 32, height: 32)
                }

                Text("ArahKita")
                    .foregroundStyle(Color.black)
                    .font(.system(size: 48, weight: .semibold))

                Spacer()

                Text("by Tukucode - 2025")
                    .foregroundStyle(Color.gray)
                    .font(.system(size: 14, weight: .medium))
            }
        }
    }
}

#Preview {
    SplashView()
}

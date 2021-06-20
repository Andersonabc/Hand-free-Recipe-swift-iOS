//
//  AsyncLoading.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/8.
//

import SwiftUI

struct RotatingCircle: View {
    @Binding var isLoading: Bool
    
    let width: CGFloat
    let duration: Double
    let size: CGFloat

    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(lineWidth: width)
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            .animation(Animation.linear(duration: duration).repeatForever(autoreverses: false))
            .frame(width: size, height: size)
    }
}

struct AsyncLoading_Previews: PreviewProvider {
    static var previews: some View {
        RotatingCircle(isLoading: .constant(false), width: 5, duration: 1, size: 100)
    }
}

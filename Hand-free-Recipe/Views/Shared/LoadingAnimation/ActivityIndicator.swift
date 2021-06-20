//
//  ActivityIndicator.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/15.
//

import SwiftUI

struct ActivityIndicator: View {
    @State var isLoading: Bool = false
    let style: ShapeStyle
    
    var body: some View {
        VStack {
            Group {
                switch style {
                case .circle(let width, let duration, let size):
                    RotatingCircle(isLoading: $isLoading, width: width, duration: duration, size: size)
                }
            }
            .onAppear {
                DispatchQueue.main.async {
                    self.isLoading = true
                }
            }
            .aspectRatio(contentMode: .fit)
        }
    }
}

public enum ShapeStyle {
    case circle(width: CGFloat = 5, duration: Double = 1, size: CGFloat = 10)
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator(style: .circle(width: 3, duration: 1, size: 100))
    }
}

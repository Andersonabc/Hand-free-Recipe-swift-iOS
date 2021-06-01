//
//  RecipeUtils.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/1.
//

import Foundation
import SwiftUI

struct DotLine: View {
    var body: some View {
        Line()
            .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .butt, dash: [4]))
            .frame(height: 1)
    }
}

struct StraightLine: View {
    var body: some View {
        Line()
            .stroke(style: StrokeStyle(lineWidth: 1))
            .frame(height: 1)
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

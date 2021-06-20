//
//  CategoryCardView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/3.
//

import SwiftUI

struct CategoryCardView: View {
    let categoryName: String
    let image: UIImage
    
    var body: some View {
        Group {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(height: 80) // autoadjusting width
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .brightness(-0.02)
                .shadow(radius: 5)
                .overlay(Text(categoryName).font(.headline).bold().foregroundColor(.white).shadow(color: .gray, radius: 10, x: 2, y: 3).padding(8), alignment: .bottomLeading)
        }
    }
}

struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(categoryName: "義大利麵", image: UIImage(named: "fish")!)
            .preferredColorScheme(.dark)
    }
}

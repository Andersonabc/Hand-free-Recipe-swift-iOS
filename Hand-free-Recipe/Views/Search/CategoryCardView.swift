//
//  CategoryCardView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/3.
//

import SwiftUI

struct CategoryCardView: View {
    let categoryImage: String
    let categoryName: String
    
    var body: some View {
        Image(categoryImage)
            .resizable()
            .scaledToFill()
            .frame(height: 80) // autoadjusting width
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .brightness(-0.02)
            .shadow(radius: 5)
            .overlay(Text(categoryName).font(.headline).bold().foregroundColor(.white).shadow(color: .gray, radius: 10, x: 2, y: 3).padding(8), alignment: .bottomLeading)
        
    }
}

struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(categoryImage: "pasta", categoryName: "義大利麵")
            .preferredColorScheme(.dark)
    }
}

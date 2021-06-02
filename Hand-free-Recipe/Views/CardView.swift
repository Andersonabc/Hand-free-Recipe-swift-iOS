//
//  CardView.swift
//  Hand-free-Recipe
//
//  Created by Steven Shen on 2021/5/31.
//

import SwiftUI

struct CardView: View {
//    let recipe: Recipe
    @State private var isFavorite = false;
    
    var body: some View {
        VStack {
            Image("breakfast")
                .resizable()
                .frame(width: 300, height: 300)
                .aspectRatio(contentMode: .fill)
                .clipped()
            
            HStack {
                Text("早餐")
                    .font(.title)
                    .fontWeight(.medium)
//                    .foregroundColor(.primary)
                    .foregroundColor(Color(.sRGB,
                                           red: 74/255,
                                           green: 74/255,
                                           blue: 74/255))
                    .padding(.bottom, 30)
                    .lineLimit(2)
                
                Spacer()
                
                Button(action: {
                    isFavorite = isFavorite ? false : true
                }, label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 21, height: 21)
                        .foregroundColor(.red)
                })
                .padding(.bottom, 30)
            }
            .layoutPriority(100)
            .padding()
            
        }
        .frame(width: 300, height: 350)
        .cornerRadius(10)
        .shadow(radius: 10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1))
        .padding([.top, .horizontal])
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

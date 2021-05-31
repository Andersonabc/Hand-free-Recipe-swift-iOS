//
//  RecipeView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/5/31.
//

import Introspect
import SwiftUI

struct RecipeView: View {
    @State var isLike: Bool = false;
    @State var isFullScreenImage: Bool = false;
    @State var isPresented: Bool = false;
    @State var uiNavigationController: UINavigationController?
    let foodImageName: String = "example_food"
    let foodName: String = "炭烤透抽"
    let cookingDuration: Int = 2400
    
    var body: some View {
        ZStack {
            VStack {
                Image(foodImageName)
                    .resizable()
                    .scaledToFit()
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1), {
                            self.isFullScreenImage.toggle()
                        })
                    }
                    .border(Color.black)
                
                VStack {
                    HStack {
                        Spacer()
                        Text(foodName)
                            .font(.largeTitle)
                        Spacer()
                        Button(action: {
                            self.isPresented.toggle()
                        }, label: {
                            Text("投影片模式")
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding()
                        })
                        .border(Color.purple)
                        .cornerRadius(3)
                        .padding(.trailing, 15)
                    }

                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 1))
                        .frame(height: 1)
                    
                    RecipeDurationView(cookingDuration: self.cookingDuration)
                    RecipeDetailView()
                    
                }
                .padding()
                

                // temporarily spacer
                Spacer()
            }
            .toolbar(content: {
                ToolBarContent(isLike: $isLike)
            })
            .navigationBarTitleDisplayMode(.inline)
            
            if (self.isFullScreenImage) {
                FullScreenModalView(isFullScreenImage: $isFullScreenImage)
                    .ignoresSafeArea(.all)
                    .introspectNavigationController { UINavigationController in
                        UINavigationController.navigationBar.isHidden = true
                        self.uiNavigationController = UINavigationController
                    }
                    .onDisappear {
                        self.uiNavigationController?.navigationBar.isHidden = false
                    }
            }
        }
    }
}

struct RecipeDetailView: View {
    var body: some View {
        Text("Hello")
    }
}

struct RecipeDurationView: View {
    var cookingDuration: Int?
    let durationList = ["天", "小時", "分鐘", "秒"]
    
    func calculatDuration() -> [Int]? {
        guard var duration = cookingDuration else { return nil }
        
        var tmp = [Int]()
        tmp.append(duration % 60)
        duration /= 60
        tmp.append(duration % 60)
        duration /= 60
        tmp.append(duration % 24)
        duration /= 24
        tmp.append(duration)

        return tmp.reversed()
    }

    var body: some View {
        if let durations = calculatDuration() {
            Label(
                title: {
                    ForEach(durations.indices) { index in
                        if (durations[index] != 0) {
                            Text("\(durations[index])\(durationList[index])")
                        }
                    }
                },
                icon: { Image(systemName: "clock") }
            )
            
            Line()
                .stroke(style: StrokeStyle(lineWidth: 1))
                .frame(height: 1)
        }
    }
}

struct FullScreenModalView: View {
    @Binding var isFullScreenImage: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Image("example_food")
                .resizable()
                .scaledToFit()
            Spacer()
        }
        .background(Color(red: 0, green: 0, blue: 0, opacity: 0.5))
        .onTapGesture {
            self.isFullScreenImage.toggle()
        }
    }
}

struct ToolBarContent: ToolbarContent {
    @Binding var isLike: Bool
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                Button(action: {
                    self.isLike.toggle()
                }, label: {
                    Image(systemName: "heart\(self.isLike ? ".fill" : "")")
                        .font(.title)
                        .frame(height: 44)
                        .padding(.trailing, 5)
                        .padding(.leading, 5)
                })
                .help(Text("Share recipe"))
                // for adjusting image size
                Spacer(minLength: 0)
            }
            .foregroundColor(.red)
        }


        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                Button(action: {
                    // TODO: do sharing
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                        .imageScale(.large)
                        .frame(height: 44, alignment: .center)
                        .padding(.trailing, 5)
                        .padding(.leading, 5)
                })
                .help(Text("Share recipe"))
                // for adjusting image size
                Spacer(minLength: 0)
            }
        }
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

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipeView()
        }
    }
}

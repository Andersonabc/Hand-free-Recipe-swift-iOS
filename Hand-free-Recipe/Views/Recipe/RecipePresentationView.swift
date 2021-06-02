//
//  RecipePresentationView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/2.
//

import SwiftUI
import LoremSwiftum

struct RecipePresentationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var eyeTrackingMode: Bool = false
    let recipeName: String
    let descriptions: [String]
    let imageURLs: [String]

    var body: some View {
        HStack {
            TabView {
                ForEach(descriptions.indices) { step in
                    RecipePresentationStepView(step: step + 1, description: descriptions[step], imageURL: imageURLs[step])
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        .padding()
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear(perform: {
                UIScrollView.appearance().alwaysBounceVertical = false
             })
        }
        .padding(.top, 50)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: CustomBackButton(presentationMode: presentationMode, recipeName: recipeName),
            trailing:
                Toggle(isOn: $eyeTrackingMode, label: {
                    Text("眼球追蹤模式")
                })
        )
    }
}

struct RecipePresentationStepView: View {
    let step: Int
    let description: String
    let imageURL: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Step \(step)")
                    .font(.largeTitle)
                Spacer()
            }
            .padding(.bottom, 5)
            Text(description)
            Spacer()
            Image(imageURL)
                .resizable()
                .scaledToFit()
                .cornerRadius(4.0)
            Spacer()
        }
        .padding()
    }
}

struct CustomBackButton: View {
    let presentationMode: Binding<PresentationMode>

    let recipeName: String

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Label(
                title: { Text(recipeName) },
                icon: { Image(systemName: "chevron.backward") }
            )
        })
    }
}

struct RecipePresentationView_Previews: PreviewProvider {
    static let descriptions = generateDesciptions()
    static let imageURLs = generateImages()

    static func generateDesciptions() -> [String] {
        var tmp = [String]()
        
        for _ in 0...6 {
            tmp.append(Lorem.sentences(2))
        }

        return tmp
    }

    static func generateImages() -> [String] {
        var tmp = [String]()
        
        for _ in 0...6 {
            tmp.append("example_food")
        }

        return tmp
    }

    static var previews: some View {
        NavigationView {
            RecipePresentationView(recipeName: "Test", descriptions: descriptions, imageURLs: imageURLs)
        }
    }
}

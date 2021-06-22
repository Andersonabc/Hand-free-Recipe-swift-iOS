//
//  RecipePresentationView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/2.
//

import SwiftUI

struct RecipePresentationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var eyeTrackingMode: Bool = false

    let recipeName: String
    var steps: [RecipeStep]

    var body: some View {
        HStack {
            TabView {
                ForEach(steps.indices) { step in
                    RecipePresentationStepView(step: step + 1, description: steps[step].description, image: steps[step].image)
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
        .navigationViewStyle(StackNavigationViewStyle())
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
    let image: String?
    @ObservedObject var imageLoader: ImageLoader
    
    init(step: Int, description: String, image: String?) {
        self.step = step
        self.description = description
        self.image = image
        self.imageLoader = ImageLoader(url: URL(string: image != nil ? image! : "http://test.com")!, cache: Environment(\.imageCache).wrappedValue)
    }

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
            
            if image != nil {
                Image(uiImage: imageLoader.image ?? UIImage(named: "placeholder")!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(4.0)
                Spacer()
            }
        }
        .padding()
        .onAppear {
            if image != nil {
                self.imageLoader.load()
            }
        }
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
                title: { Text(recipeName).frame(width: UIScreen.main.bounds.width / 3).lineLimit(1) },
                icon: { Image(systemName: "chevron.backward") }
            )
        })
    }
}

struct RecipePresentationView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            RecipePresentationView(recipeName: "Test", steps: generateFakeSteps())
        }
    }
}

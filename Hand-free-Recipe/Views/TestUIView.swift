//
//  SwiftUIView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/3.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1...500, id: \.self, content: SampleRow.init)
            }
        }
        .frame(height: 300)
    }
}

struct SampleRow: View {
    let id: Int

    var body: some View {
        Text("Row \(id)")
    }

    init(id: Int) {
        print("Loading row \(id)")
        self.id = id
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

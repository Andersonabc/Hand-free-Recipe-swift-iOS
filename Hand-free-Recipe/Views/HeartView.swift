//
//  HeartView.swift
//  Hand-free-Recipe
//
//  Created by Steven Shen on 2021/6/12.
//

import SwiftUI

struct HeartView: View {
    
    @State private var selectedIndex = 0
    @GestureState private var dragOffset = CGSize.zero
    @State private var offset: CGFloat = 0
    
    var drag: some Gesture {
        DragGesture()
            .updating($dragOffset,
                      body: { (value, state, transaction) in
                        state = value.translation
            })
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading,
                   spacing: 0) {
                SlideTabView(selection: $selectedIndex,
                             tabs: ["歷史紀錄", "我的最愛"])
                    .padding(.top, -50)
                
                ScrollView(.horizontal,
                           showsIndicators: false) {
                    TabView(selection: $selectedIndex.animation()) {
                        HistoryView()
                        .tag(0)
                        FavoriteView()
                        .tag(1)
                    }
                    .animation(.spring())
                    .frame(width: UIScreen.main.bounds.width)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }
            .background(Color("MainView"))
            .navigationBarHidden(true)
        }
    }
}

struct HeartView_Previews: PreviewProvider {
    static var previews: some View {
        HeartView()
            .preferredColorScheme(.light)
    }
}

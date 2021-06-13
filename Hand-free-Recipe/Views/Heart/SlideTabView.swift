//
//  SlideTabView.swift
//  Hand-free-Recipe
//
//  Created by Steven Shen on 2021/6/5.
//

import SwiftUI

struct SlideTabView: View {
    
    @Binding var selection: Int
    @State private var tabIndex = 0 {
        didSet {
            selection = tabIndex
        }
    }
    @State var barOffset: CGFloat = 0
    
    let tabs: [String]
    let tabColor: Color
    let tabHeight: CGFloat
    let animation: Animation
    let activeAccent: Color
    let inactiveAccent: Color
    let barColor: Color
    let barHeight: CGFloat
    
    init(selection: Binding<Int>,
         tabs: [String],
         tabColor: Color = Color("ToolBar"),
         tabHeight: CGFloat = 65,
         animation: Animation = .spring(),
         activeAccent: Color = Color("ActiveAccent"),
         inactiveAccent: Color = Color("ActiveAccent").opacity(0.7),
         barColor: Color = Color("SelectionBar"),
         barHeight: CGFloat = 2) {
        self._selection = selection
        self.tabs = tabs
        self.tabColor = tabColor
        self.tabHeight = tabHeight
        self.animation = animation
        self.activeAccent = activeAccent
        self.inactiveAccent = inactiveAccent
        self.barColor = barColor
        self.barHeight = barHeight
    }
    
    private func isSelected(tab: String) -> Bool {
        return tabs[tabIndex] == tab
    }
    
    private func barXOffset(from totalWidth: CGFloat) -> CGFloat {
        return self.barWidth(from: totalWidth) * CGFloat(tabIndex)
    }
    
    private func barWidth(from totalWidth: CGFloat) -> CGFloat {
        return totalWidth / CGFloat(tabs.count)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(spacing: 0) {
                ForEach(self.tabs, id:\.self) { tab in
                    Button(action: {
                        let selection = self.tabs.firstIndex(of: tab) ?? 0
                        self.tabIndex = selection
                    }) {
                        HStack {
                            Spacer()
                            Text(tab)
                                .fontWeight(.medium)
                                .font(.headline)
                            Spacer()
                        }
                        .padding(.bottom, 15)
                    }
                    .padding(.top, tabHeight)
                    .accentColor(
                        self.isSelected(tab: tab)
                            ? self.activeAccent
                            : self.inactiveAccent)
                    .background(
                        self.isSelected(tab: tab)
                            ? self.tabColor
                            : self.tabColor)
                }
            }
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(self.barColor)
                        .frame(width: self.barWidth(from: geometry.size.width),
                               height: self.barHeight)
                        .offset(x: self.barXOffset(from: geometry.size.width),
                                y: -1 * self.barHeight)
                        .animation(.spring(), value: tabIndex)
                    
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: self.barWidth(from: geometry.size.width),
                               height: self.barHeight)
                }
            }
            .frame(height: 0)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct SlideTabView_Previews: PreviewProvider {
    static var previews: some View {
        SlideTabView(selection: .constant(0),
                     tabs: ["歷史紀錄", "我的最愛"])
            .preferredColorScheme(.light)
    }
}

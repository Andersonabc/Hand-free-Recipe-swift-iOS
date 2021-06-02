//
//  SearchView.swift
//  Hand-free-Recipe
//
//  Created by 李承紘 on 2021/6/2.
//

import SwiftUI

struct SearchView: View {
    @State var gotoSearchPage: Bool = false
    @State var hist = History()
    @State private var searchText = ""
    private var Items = [ SearchRecord(name: "Chicken and waffles"),
                          SearchRecord(name: "Sweet potato casserole"),
                          SearchRecord(name: "Meatloaf"),
                          SearchRecord(name: "Taco"),
                          SearchRecord(name: "fish and chips")
                                ]
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Let's search what you love!")
                        .font(.system(size: 30, weight: .light, design: .rounded))
                }.padding(.top, -60)
                SearchBar(text: $searchText, gotoSearchPage:$gotoSearchPage, hist: $hist).padding(.top, -20)
                
                if(gotoSearchPage){
                    List (self.Items.filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })) { (item) in
                            HStack {
                                Button(action: {
                                    self.gotoSearchPage = false
                                }, label: {
                                    Text(item.name)
                                })
                            }
                        }
                }else{
                    List (self.hist.data) { (item) in
                            HStack {
                                Image(systemName: "arrow.counterclockwise")
                                Button(action: {
                                    print("search")
                                    self.searchText = item.name
                                    self.gotoSearchPage = true
                                }, label: {
                                    Text(item.name)
                                })
                                Spacer()
                                Button(action: {
                                    print("delete")
                                    self.gotoSearchPage = false
                                    self.hist.deleteHist(at: item)
                                }, label: {
                                    Image(systemName: "xmark.circle").foregroundColor(Color.red)
                                }).buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    
                }

            }
        }
    }

}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

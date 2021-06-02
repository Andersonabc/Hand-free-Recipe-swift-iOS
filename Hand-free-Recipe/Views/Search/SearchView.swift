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
    @State var isEditing: Bool = false
    private var Items = [ SearchRecord(name: "Chicken and waffles"),
                          SearchRecord(name: "Sweet potato casserole"),
                          SearchRecord(name: "Meatloaf"),
                          SearchRecord(name: "Taco"),
                          SearchRecord(name: "fish and chips")
                                ]
    var body: some View {
        NavigationView {
            //VStack {
                VStack{
                    if(isEditing){
                        VStack{
                            HStack {
                                Text("Let's search what you love!")
                                    .font(.system(size: 30, weight: .light, design: .rounded))
                            }.padding(.top, -60)
                            SearchBar(text: $searchText, isEditing: $isEditing, gotoSearchPage:$gotoSearchPage, hist: $hist).padding(.top, -20)
                        }
                        if(searchText == ""){
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
                        }else{
                            List (self.Items.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) })) { (item) in
                                    HStack {
                                        Button(action: {
                                            self.gotoSearchPage = false
                                        }, label: {
                                            Text(item.name)
                                        })
                                    }
                                }
                        }
      
                    }else{
                        VStack(alignment: .center){
                            VStack{
                                HStack {
                                    Text("Let's search what you love!")
                                        .font(.system(size: 30, weight: .light, design: .rounded))
                                }.padding(0)
                                SearchBar(text: $searchText, isEditing: $isEditing, gotoSearchPage:$gotoSearchPage, hist: $hist)
                            }
                            Text("Popular searches").padding(10).frame(maxWidth: .infinity, alignment: .leading).font(.title)
                            HStack{
                                Image("fish").resizable().frame(width: 180, height: 100)
                                Image("hamburger").resizable().frame(width: 180, height: 100)
                            }.padding(.top, 10)
                            HStack{
                                Image("pasta").resizable().frame(width: 180, height: 100)
                                Image("spaghetti").resizable().frame(width: 180, height: 100)
                            }
                        }.padding(.top, -390)

                    }
                }.padding(0)
                
                

            }
    }

}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

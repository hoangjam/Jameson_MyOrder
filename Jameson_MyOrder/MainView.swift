//
//  MainView.swift
//  Jameson_MyOrder
//
//  Created by Jameson Hoang on 2021-10-01.
//

import SwiftUI

struct MainView: View {
    @State private var selection: Int? = nil
    
    var body: some View {
        VStack{
            NavigationLink(destination: ContentView(), tag:1, selection: self.$selection){}
            
            TabView{
                ContentView().tabItem(){
                    Image(systemName: "menucard")
                    Text("Menu")
                }
                .tag(1)
                OrdersView().tabItem(){
                    Image(systemName: "line.number")
                    Text("Order List")
                }
                .tag(2)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

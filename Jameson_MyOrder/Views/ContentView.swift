//
//  ContentView.swift
//  Jameson_MyOrder
//
//  Created by Jameson Hoang|991548515 on 2021-09-27.
//

import SwiftUI

struct ContentView: View {
    
    @State private var type : String = ""
    @State private var size : String = ""
    @State private var quantity : String = ""
    
    @State private var orders : [Coffee] = []
    let selectedCoffeeIndex : Int
    
    let types = ["Dark Roast", "Original Blend", "Vanilla", "Black"]
    let sizes = ["Small", "Medium", "Large"]
    
    @State private var selection: Int? = nil
    
    @EnvironmentObject var coreDBHelper: CoreDBHelper
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: OrdersView(selectedCoffeeIndex: 0), tag:2, selection: self.$selection){}
                
                Text("Place Coffee Order")
                    .foregroundColor(.green)
                    .fontWeight(.bold)
                    .font(.system(size: 40))
                    .padding()
                
                Form {
                    Section {
                        Picker("Coffee Type", selection: $type) {
                            ForEach(types, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    Section {
                        Picker("Size", selection: $size) {
                            ForEach(sizes, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    TextField("Quantity", text: $quantity)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .frame(maxWidth: .infinity)
                    Button(action: {
                        
                        print("Submitting order")
                        self.addNewCoffee()
                    }){
                        Text("Add to Order")
                            .foregroundColor(Color.white)
                            .font(.title2)
                            .padding(10)
                    }
                    .background(Color.green)
                    .frame(maxWidth: .infinity)
                    Spacer()
                }// EO Form
                
            }// EO VStack
            .frame(maxWidth: .infinity)
            .navigationBarItems(trailing: Button(action: {
                self.selection = 2
            }){
                Text("Order List")
            })
        }// EO NavigationView
    }// EO body
    
    private func addNewCoffee(){
        print("Adding coffee to database")
        if (!self.quantity.isEmpty){
            self.coreDBHelper.insertCoffee(newCoffee: Coffee(type: self.type, size: self.size, quantity: self.quantity))
        }
        else{
            print(#function, "Quantity of a coffee order can't be empty")
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

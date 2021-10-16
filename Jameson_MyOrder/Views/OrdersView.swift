//
//  OrdersView.swift
//  Jameson_MyOrder
//
//  Created by Jameson Hoang|991548515 on 2021-09-30.
//

import SwiftUI

struct OrdersView: View {
    
    @State private var type : String = ""
    @State private var size : String = ""
    @State private var quantity : String = ""
    
    @EnvironmentObject var coreDBHelper : CoreDBHelper
    
    var orders : [Coffee] = []
    
    let types = ["Dark Roast", "Original Blend", "Vanilla", "Black"]
    let sizes = ["Small", "Medium", "Large"]
    
    let selectedCoffeeIndex : Int
    
    var body: some View {
        Text("Coffee Orders")
            .foregroundColor(.green)
            .fontWeight(.bold)
            .font(.system(size: 30))
            .padding()
        ZStack(alignment: .bottom){
            if (self.coreDBHelper.orders.count > 0){
                List{
                    ForEach (self.coreDBHelper.orders.enumerated().map({$0}), id: \.element.self){ i, currentCoffee in
                        NavigationLink(destination: ContentView(selectedCoffeeIndex: i)){
                            VStack(alignment: .leading){
                                Text("Coffee Type: \(currentCoffee.type)")
                                Text("Coffee Size: \(currentCoffee.size)")
                                Text("Quantity: \(currentCoffee.quantity)")
                            }.padding(15)
                                .onTapGesture {
                                    print("Current coffee order selected: \(self.coreDBHelper.orders[i].id)")
                                    
                                }
                        }//NavigationLink
                    }//ForEach
                    .onDelete(perform: {indexSet in
                        for index in indexSet{
                            self.coreDBHelper.deleteCoffee(coffeeID: self.coreDBHelper.orders[index].id!)
                            self.coreDBHelper.orders.remove(atOffsets: indexSet)
                        }
                    })
                }//List
            }
            else{
                VStack{
                    Text("No orders placed yet")
                    Spacer()
                }
            }
        }//EOZstack
        .onAppear(){
            self.coreDBHelper.getAllCoffees()
        }
    }//EObody
    
    private func updateCoffee(){
        self.coreDBHelper.orders[selectedCoffeeIndex].type = self.type
        self.coreDBHelper.orders[selectedCoffeeIndex].size = self.size
        self.coreDBHelper.orders[selectedCoffeeIndex].quantity = self.quantity
        
        self.coreDBHelper.updateCoffee(updatedCoffee: self.coreDBHelper.orders[selectedCoffeeIndex])
    }
    
    //    struct OrdersView_Previews: PreviewProvider {
    //        static var previews: some View {
    //            OrdersView()
    //        }
    //    }
    //}
}

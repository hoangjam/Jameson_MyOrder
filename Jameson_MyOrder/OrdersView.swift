//
//  OrdersView.swift
//  Jameson_MyOrder
//
//  Created by Jameson Hoang|991548515 on 2021-09-30.
//

import SwiftUI

struct OrdersView: View {
    
    
    var orders : [Coffee] = []
    
    var body: some View {
        Text("Coffee Orders")
            .foregroundColor(.green)
            .fontWeight(.bold)
            .font(.system(size: 40))
            .padding()
        VStack{
            List{
                ForEach(orders, id: \.id){ coffee in
                    Section(header: Text("Order #\(coffee.id)")){
                        Text("Coffee Type: \(coffee.type)\nSize: \(coffee.size)\nQuantity: \(coffee.quantity)")
                    }
                }
            }
        }
    }
    
    
    struct OrdersView_Previews: PreviewProvider {
        static var previews: some View {
            OrdersView()
        }
    }
}

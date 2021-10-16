//
//  Coffee.swift
//  Jameson_MyOrder
//
//  Created by Jameson Hoang|991548515 on 2021-10-01.
//

import Foundation

class Coffee{
//struct Coffee : Hashable{
    var id = UUID()
    var type : String = ""
    var size : String = ""
    var quantity : String = ""
    
    init(){
    }
    
    init(type: String, size: String, quantity: String){
        self.type = type
        self.size = size
        self.quantity = quantity
    }
}

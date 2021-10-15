//
//  CoffeeMO.swift
//  Jameson_MyOrder
//
//  Created by Jameson Hoang on 2021-10-14.
//

import Foundation
import CoreData

@objc(CoffeeMO)
final class CoffeeMO: NSManagedObject{
    @NSManaged var id: UUID?
    @NSManaged var type: String
    @NSManaged var size: String
    @NSManaged var quantity: String
}

extension CoffeeMO{
    func convertToCoffee() -> Coffee{
        Coffee(type: type, size: size, quantity: quantity)
    }
}

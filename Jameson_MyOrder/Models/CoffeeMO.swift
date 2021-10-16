//
//  CoffeeMO.swift
//  Jameson_MyOrder
//
//  Created by Jameson Hoang|991548515 on 2021-10-14.
//

import Foundation
import CoreData

@objc(CoffeeMO)
final class CoffeeMO: NSManagedObject{
    @NSManaged var id: UUID?
    @NSManaged var type: String
    @NSManaged var size: String
    @NSManaged var quantity: String
    @NSManaged var dateAdded: Date
}

extension CoffeeMO{
    func convertToCoffee() -> Coffee{
        Coffee(type: type, size: size, quantity: quantity)
    }
}

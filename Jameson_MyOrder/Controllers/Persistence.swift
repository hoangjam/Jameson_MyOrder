//
//  Persistence.swift
//  Jameson_MyOrder
//
//  Created by Jameson Hoang on 2021-10-15.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        return result
    }()
    
    let container : NSPersistentContainer
    
    init(inMemory: Bool = false){
        container = NSPersistentContainer(name: "Jameson_MyOrder")
        
        if inMemory{
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError?{
                print("Unable to access CoreData BookDB. \(error)")
            }
        })
    }
    
}

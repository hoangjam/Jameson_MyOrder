//
//  CoreDBHelper.swift
//  Jameson_MyOrder
//
//  Created by Jameson Hoang on 2021-10-14.
//

import Foundation
import CoreData

class CoreDBHelper : ObservableObject{
    
    @Published var orders = [CoffeeMO]()
    
    private let ENTITY_NAME = "CoffeeMO"
    private let MOC : NSManagedObjectContext
    private static var shared: CoreDBHelper?
    
    static func getInstance() -> CoreDBHelper{
        if shared == nil{
            shared = CoreDBHelper(context: PersistenceController.preview.container.viewContext)
        }
        return shared!
    }
    
    init(context: NSManagedObjectContext) {
        self.MOC = context
    }
    
    func insertCoffee(newCoffee: Coffee){
        do{
            let coffeeTobeInserted = NSEntityDescription.insertNewObject(forEntityName: self.ENTITY_NAME, into: self.MOC) as! CoffeeMO
            
            coffeeTobeInserted.id = UUID()
            coffeeTobeInserted.type = newCoffee.type
            coffeeTobeInserted.size = newCoffee.size
            coffeeTobeInserted.quantity = newCoffee.quantity
            
            if self.MOC.hasChanges{
                try self.MOC.save()
                print(#function, "Coffee successfully added to database")
            }
            
        }catch let error as NSError{
            print(#function, "Could not add coffee \(error)")
        }
    }
    
    func getAllCoffees(){
        let fetchRequest = NSFetchRequest<CoffeeMO>(entityName: self.ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "title", ascending: true)]
        
        do{
            let result = try self.MOC.fetch(fetchRequest)
            print(#function, "Number of orders retrieved : \(result.count)")
            self.orders.removeAll()
            self.orders.insert(contentsOf: result, at: 0)
            print(#function, "Result from DB \(result)")
            
        }catch let error as NSError{
            print(#function, "Couldn't retrieve data from DB \(error)")
        }
    }
    
    private func searchCoffee(coffeeID : UUID) -> CoffeeMO?{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_NAME)
        let predicateID = NSPredicate(format: "id == %@", coffeeID as CVarArg)
        fetchRequest.predicate = predicateID
        
        do{
            let result = try self.MOC.fetch(fetchRequest)
            
            if result.count > 0{
                return result.first as? CoffeeMO
            }
            
        }catch let error as NSError{
            print(#function, "Unable to search for given ID \(error)")
        }
        return nil
    }
    
    func deleteCoffee(coffeeID : UUID){
        let searchResult = self.searchCoffee(coffeeID: coffeeID)
        
        if (searchResult != nil){
            do{
                self.MOC.delete(searchResult!)
                try self.MOC.save()
                print(#function, "Order deleted successfully")
                
            }
            catch let error as NSError{
                print(#function, "Unable to search for given ID \(error)")
            }
        }
        else{
            print(#function, "No matching record found for given bookID \(coffeeID)")
        }
    }
    
    func updateCoffee(updatedCoffee: CoffeeMO){
        let searchResult = self.searchCoffee(coffeeID: updatedCoffee.id! as UUID)
        
        if (searchResult != nil){
            do{
                let coffeeToUpdate = searchResult!
                coffeeToUpdate.type = updatedCoffee.type
                coffeeToUpdate.size = updatedCoffee.size
                coffeeToUpdate.quantity = updatedCoffee.quantity
                
                try self.MOC.save()
                
                print(#function, "Order details updated successfully")
                
            }catch let error as NSError{
                print(#function, "Unable to search for given ID \(error)")
            }
        }else{
            print(#function, "No matching record found for given coffeeID \(updatedCoffee.id!)")
        }
    }
}

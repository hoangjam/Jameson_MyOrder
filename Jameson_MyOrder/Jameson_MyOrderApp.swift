//
//  Jameson_MyOrderApp.swift
//  Jameson_MyOrder
//
//  Created by Jameson Hoang on 2021-09-27.
//

import SwiftUI

@main
struct Jameson_MyOrderApp: App {
//    var coffee = Coffee()
    let persistenceController = PersistenceController.shared
    let coreDBHelper = CoreDBHelper(context: PersistenceController.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            ContentView(selectedCoffeeIndex: 0).environmentObject(coreDBHelper)
//                .environmentObject(coffee)
        }
    }
}

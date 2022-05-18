//
//  CoreDataRelationshipOfBootcamp.swift
//  SwiftUIBootcamp-Intermediate
//
//  Created by MEWO on 18.05.2022.
//

import SwiftUI
import CoreData

// 3 ENTITIES - Business, Department, Employee


class CoreDataManager {
    
    static let instance = CoreDataManager()
    let container : NSPersistentContainer
    let context : NSManagedObjectContext
    
    
    init() {
        container = NSPersistentContainer(name: "")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("data error \(error)")
            }
        }
        context = container.viewContext
    }
    
    
    func save(){
        do{
            try context.save()

        }catch let error {
            print("error saving : \(error.localizedDescription)")
        }
    }
}

class CoreDataRelationshipViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
}

struct CoreDataRelationshipOfBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct CoreDataRelationshipOfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipOfBootcamp()
    }
}

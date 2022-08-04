//
//  CoreDataOfBootcamp.swift
//  SwiftUIBootcamp-Intermediate
//
//  Created by MEWO on 15.05.2022.
//

import SwiftUI
import CoreData

                //VIEWMODEL

class CoreDataViewModel: ObservableObject{
    
    let container: NSPersistentContainer
    @Published var savedEntities : [SingerEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "Singer")
        container.loadPersistentStores { (description, error) in
            if let error = error{
                print("error loading core data \(error)")
            }
        }
        fetchSinger()
    }
    
    func fetchSinger(){
        let request = NSFetchRequest<SingerEntity>(entityName: "SingerEntity")
        
        do{
            savedEntities = try container.viewContext.fetch(request)

        }catch let error {
            print("error fetching \(error)")
        }
    }
    
    func addSinger(text: String){
        let newSinger = SingerEntity(context: container.viewContext)
        newSinger.name = text
        save()
    }
    
    func deleteSinger(indexSet: IndexSet){
        guard let index = indexSet.first else{return}
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        save()
    }
    
    func save(){
        do{
            try container.viewContext.save()
            fetchSinger()
        } catch let error {
            print("error saving: \(error)")
        }
    }
}


struct CoreDataOfBootcamp: View {
    @StateObject var vm = CoreDataViewModel()
    @State var singerTextField : String = ""
    var body: some View {
        NavigationView{
            VStack(spacing: 10){
                TextField(" type here...", text: $singerTextField)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity )
                    .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .cornerRadius(15)
                    .shadow(color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), radius: 10, x: 0.0, y: 0.0)
                    .padding()
                Button(action: {
                    guard !singerTextField.isEmpty else{return}
                    vm.addSinger(text: singerTextField)
                    singerTextField = ""
                }, label: {
                    Text("Add")
                        .font(.headline)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 55)
                        .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                        .cornerRadius(15)
                        .shadow(color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), radius: 5, x: 0.0, y: 0.0)
                    
                })
                List{
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name ?? "")
                    }.onDelete(perform: vm.deleteSinger)
                }.listStyle(PlainListStyle())
            }
        }
    }
}

struct CoreDataOfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataOfBootcamp()
    }
}

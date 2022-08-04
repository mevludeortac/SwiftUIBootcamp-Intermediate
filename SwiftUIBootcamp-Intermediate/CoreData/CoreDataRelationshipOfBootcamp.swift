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
    
    static let instance = CoreDataManager() //Singleton
    let container : NSPersistentContainer
    let context : NSManagedObjectContext
    
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
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
            print("saved")
        }catch let error {
            print("error saving : \(error.localizedDescription)")
        }
    }
}

class CoreDataRelationshipViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    @Published var businesses: [BusinessEntity] = []
    @Published var departments : [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init(){
        getBusiness()
        getDepartment()
        getEmployee()
    }
    
        func addBusiness(){
            let newBusiness = BusinessEntity(context: manager.context)
            newBusiness.name = "Microsoft"
            
            //add existing department to the new business
            newBusiness.departments = [departments[0], departments[1]]
            
            //add existing employees to the new business
            newBusiness.employees = [employees[1]]
            
            //add new businees to existing department
            //newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
            
            //add new business to existing employee
            //newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
            save()
        }
        func addDepartment(){
            let newDepartment = DepartmentEntity(context: manager.context)
            newDepartment.name = "Engineering"
            //newDepartment.businesses = [businesses[0]]
            
            //newDepartment.employees = [employees[1]]
            newDepartment.addToEmployees(employees[1])
            save()
        }
        func addEmployee(){
            let newEmployee = EmployeeEntity(context: manager.context)
            newEmployee.name = "phobe"
            newEmployee.age =  27
            newEmployee.dateJoined = Date()
            
            //newEmployee.business = businesses[0]
            //newEmployee.department = departments[0]
            save()
        }
        func getBusiness(){
            let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
            do{
                businesses = try manager.context.fetch(request)
            }catch let error {
                print("error fetching \(error.localizedDescription)")
            }
        }
        func getDepartment(){
            let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
            do{
                departments = try manager.context.fetch(request)
            }catch let error {
                print("error fetching \(error.localizedDescription)")
            }
        }
        func getEmployee(){
            let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
            do{
                employees = try manager.context.fetch(request)
            } catch let error{
                print("error fetching \(error.localizedDescription)")
            }
        }
        func save(){
            businesses.removeAll()
            departments.removeAll()
            employees.removeAll()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.manager.save()
                self.getBusiness()
                self.getDepartment()
                self.getEmployee()
            }

        }
}

struct CoreDataRelationshipOfBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 10){
                    Button(
                        action: {
                            vm.addBusiness()
                        },
                        label: {
                        Text("perform action")
                            .foregroundColor(.white)
                            .frame(width: 150, height: 55)
                            .background(Color.black)
                            .cornerRadius(15)
                    })
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        HStack{
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    })
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        HStack{
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                    })
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        HStack{
                            ForEach(vm.employees) { employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    })
                }.padding()
            }.navigationTitle("Core Data Relationship")
        }
    }
}

struct CoreDataRelationshipOfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipOfBootcamp()
    }
}
struct BusinessView: View{
    let entity: BusinessEntity
    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("name: \(entity.name ?? "")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity]{
                Text("Departments:")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects  as? [EmployeeEntity]{
                Text("Employees: ")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                        .bold()
                }
            }
        }).padding()
        .frame(maxWidth: 400)
        .background(Color.orange)
        .cornerRadius(15)
        
    }
}
struct DepartmentView: View{
    let entity : DepartmentEntity
    
    var body: some View{
        VStack(alignment: .leading, spacing: 10, content: {
            Text("name: \(entity.name ?? "")")
                .bold()
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity]{
                Text("Businesses: ")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                        .bold()
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity]{
                Text("employees: ")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                        .bold()
                }
            }
        }).padding()
        .frame(maxWidth: 400)
        .background(Color.green)
        .cornerRadius(15)
        
    }
}
struct EmployeeView: View {
    let entity: EmployeeEntity
    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text("name: \(entity.name ?? "")")
                .bold()
            Text("age: \(entity.age)")
            Text("join date: \(entity.dateJoined ?? Date())")
            Text("business: ")
            Text(entity.business?.name ?? "")
                .bold()
            Text("department: ")
                .bold()
            Text(entity.department?.name ?? "")
        })
        .padding()
        .frame(maxWidth: 400)
        .background(Color.purple)
        .cornerRadius(15)
    }
}

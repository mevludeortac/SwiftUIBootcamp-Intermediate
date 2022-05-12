//
//  SortFilterAndMapInDataArray.swift
//  SwiftUIBootcamp-Intermediate
//
//  Created by MEWO on 11.05.2022.
//

import SwiftUI

struct Usermodel: Identifiable {
    let id = UUID().uuidString
    let name : String
    let points : Int
    let isVerified : Bool
}
class ArrayModificationModel: ObservableObject{
    @Published var dataArray : [Usermodel] = []
    @Published var filteredArray: [Usermodel] = []
    @Published var mappedArray: [String] = []
    init(){
        getUsers()
        updateFilteredArray()
    }
    func getUsers(){
        let userHerbin = Usermodel.init(name: "herbin", points: 100, isVerified: true)
        let userSeren = Usermodel.init(name: "seren", points: 100, isVerified: true)
        let userAnil = Usermodel.init(name: "anil", points: 98, isVerified: true)
        let userMerve = Usermodel.init(name: "merve", points: 67, isVerified: false)
        let userAltu = Usermodel.init(name: "altuğ", points: 43, isVerified: false)
        let userKubra = Usermodel.init(name: "kübra", points: 87, isVerified: true)
        let userNaz = Usermodel.init(name: "naz", points: 17, isVerified: true)
        self.dataArray.append(contentsOf: [userNaz, userHerbin,userAnil, userSeren, userMerve, userAltu, userKubra])
    
    }
    func updateFilteredArray(){
        // SORT
            /*
                 filteredArray = dataArray.sorted(by: {$0.points > $1.points})
             
                 //        filteredArray  = dataArray.sorted { (user1, user2) -> Bool in
                 //            return user1.points > user2.points
                 //        }
             
             */
        
        // FILTER
        /*
             //            filteredArray = dataArray.filter({ (user) -> Bool in
             //                //return user.points > 90
             //                //return !user.isVerified
             //                return user.name.contains("n")
             //            })
                     filteredArray = dataArray.filter({ $0.isVerified})
         */
        
        // MAP
        /*
         
                 mappedArray = dataArray.map({ (user) -> String in
                 //            return user.name
                 //        })
                 //        mappedArray = dataArray.map({$0.name})
                 //        mappedArray = dataArray.compactMap({ (user) -> String? in
                 //            return user.name
                 //        })
                 //        mappedArray = dataArray.compactMap({$0.name})
                 //                let sort = dataArray.sorted(by: {$0.points > $1.points})
                 //                let filter = dataArray.filter({$0.isVerified})
                 //                let mapped
                 //dataArray.compactMap({$0.name})
         */


        mappedArray = dataArray
            .sorted(by: {$0.points > $1.points})
            .filter({$0.isVerified})
            .compactMap({$0.name})

    }
}
struct SortFilterAndMapInDataArray: View {
    @StateObject var vm = ArrayModificationModel()
    var body: some View {
        ScrollView{
            VStack(spacing:15) {
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                }
                /*
                 ForEach(vm.filteredArray) { user in
                     VStack(alignment: .leading){
                         Text(user.name)
                             .font(.title)
                             .fontWeight(.semibold)
                         HStack{
                             Text("Points: \(user.points)")
                                 .fontWeight(.black)
                             Spacer()
                             if user.isVerified {
                                 Image(systemName: "checkmark.circle")
                                     .font(.largeTitle)
                                     .foregroundColor(.blue)

                             }
                         }
                     }.foregroundColor(.white)
                     .padding()
                     .frame(height: 150)
                     .background(Color(#colorLiteral(red: 1, green: 0.3675372388, blue: 0.8163292499, alpha: 1)))
                     .cornerRadius(15)
                     .padding(.horizontal)
                 }
                 */
                
            }
        }
        
    }
}

struct SortFilterAndMapInDataArray_Previews: PreviewProvider {
    static var previews: some View {
        SortFilterAndMapInDataArray()
    }
}

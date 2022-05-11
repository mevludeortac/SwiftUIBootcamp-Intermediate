//
//  HashableOfBootcamp.swift
//  SwiftUIBootcamp-Intermediate
//
//  Created by MEWO on 11.05.2022.
//

import SwiftUI
struct MyHashSampleModel: Hashable{
    let title: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
struct HashableOfBootcamp: View {
    let data: [MyHashSampleModel] = [
        MyHashSampleModel(title: "one"),
        MyHashSampleModel(title: "two"),
        MyHashSampleModel(title: "three"),
        MyHashSampleModel(title: "four"),
        MyHashSampleModel(title: "five")

    ]
    var body: some View {
        ScrollView{
            VStack(spacing:20){
                ForEach(data, id: \.self) { item in
                    Text(item.hashValue.description)
                        .font(.title)
                }
            }
        }
    }
}

struct HashableOfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HashableOfBootcamp()
    }
}

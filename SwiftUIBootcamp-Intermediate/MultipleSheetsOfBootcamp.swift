//
//  MultipleSheetsOfBootcamp.swift
//  SwiftUIBootcamp-Intermediate
//
//  Created by MEWO on 9.05.2022.
//

import SwiftUI

struct SampleModel : Identifiable{
    let id = UUID().uuidString
    let title : String
}
// 1 - use a binding
// 2 - use multiple .sheets
// 3 - use $item

struct MultipleSheetsOfBootcamp: View {
    
    @State var selectedModel : SampleModel? = nil
    var body: some View {
        VStack(spacing:10){
            ForEach(0..<20) { index in
                Button("Button \(index)") {
                    selectedModel = SampleModel(title: "\(index)")
                }
            }
        }.sheet(item: $selectedModel) { model in
            NextScreen(selectedModel: model)
        }
}

struct NextScreen : View {
    let selectedModel : SampleModel
    var body: some View{
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct MultipleSheetsOfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsOfBootcamp()
    }
}
}

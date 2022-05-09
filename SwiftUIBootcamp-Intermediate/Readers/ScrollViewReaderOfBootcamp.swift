//
//  ScrollViewReaderOfBootcamp.swift
//  SwiftUIBootcamp-Intermediate
//
//  Created by MEWO on 9.05.2022.
//

import SwiftUI

struct ScrollViewReaderOfBootcamp: View {
    @State var textFieldText : String = ""
    @State var scrollToIndex : Int = 0
    var body: some View {
        VStack {
            TextField("  type something here...", text: $textFieldText)
                .frame(height: 40)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("click to go to \(textFieldText)") {
                withAnimation(.spring()){
                    if let  index = Int(textFieldText)
                     {
                        scrollToIndex = index
                    }
                }
            }
            ScrollView{
                ScrollViewReader { proxy in
                    ForEach(0..<50) { index  in
                        Text("index: \(index)")
                            .font(.headline)
                            .frame(width: 400, height: 170)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: .black, radius: 15)
                            .padding()
                            .id(index)
                    }.onChange(of: scrollToIndex, perform: { value in
                        withAnimation(.spring()){
                            proxy.scrollTo(value, anchor: .center)
                        }
                    })
                }
            }
        }
    }
}

struct ScrollViewReaderOfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderOfBootcamp()
    }
}

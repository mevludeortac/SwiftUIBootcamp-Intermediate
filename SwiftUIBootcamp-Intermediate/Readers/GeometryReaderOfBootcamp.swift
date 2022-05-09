//
//  GeometryReaderOfBootcamp.swift
//  SwiftUIBootcamp-Intermediate
//
//  Created by MEWO on 9.05.2022.
//

import SwiftUI

struct GeometryReaderOfBootcamp: View {
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack{
                ForEach(0..<20) { index in
                    GeometryReader{ geometry in
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.green)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 20),
                                axis: (x: 0.0, y: 1.0, z: 0.0))
                    }.frame(width: 300, height: 250)
                    .padding()

                }
            }
        })
        
        
        // BASIC
        
//        GeometryReader{ geometry in
//            HStack(spacing: 0) {
//                Rectangle()
//                    .fill(Color.purple)
//                    .frame(width: geometry.size.width * 0.6666)
//                Rectangle()
//                    .fill(Color.orange)
//            }.ignoresSafeArea()
//        }
        
    }
}

struct GeometryReaderOfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderOfBootcamp()
    }
}

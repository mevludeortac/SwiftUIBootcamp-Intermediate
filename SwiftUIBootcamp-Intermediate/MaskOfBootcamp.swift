//
//  MaskOfBootcamp.swift
//  SwiftUIBootcamp-Intermediate
//
//  Created by MEWO on 10.05.2022.
//

import SwiftUI

struct MaskOfBootcamp: View {
    
    @State var rating: Int = 3
    
    var body: some View {
            
        ZStack{
            starsView
                .overlay(overlayView.mask(starsView))
            //When you apply an overlay to a view, the original view continues to provide the layout characteristics for the resulting view.
        }
    }
    private var overlayView: some View{
        GeometryReader{ geometry in
            ZStack(alignment: .leading){
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width:CGFloat (rating) / 5 * geometry.size.width)
            }
        }.allowsHitTesting(false)
        }
    private var starsView: some View {
        
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(rating >= index ? Color.yellow : Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            rating = index
                        }
                    }
            }
        }
    }
}
struct MaskOfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MaskOfBootcamp()
    }
}

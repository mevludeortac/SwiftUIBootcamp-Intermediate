//
//  MagnificationGestureOfBootcamp.swift
//  SwiftUIBootcamp-Intermediate
//
//  Created by MEWO on 8.05.2022.
//

import SwiftUI

struct MagnificationGestureOfBootcamp: View {
    @State var currentAmount : CGFloat = 0
    @State var lastAmount : CGFloat = 0
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Circle()
                    .foregroundColor(.purple)
                    .frame(width: 30, height: 30, alignment: .leading)
                Text("Herbin")
                Spacer()
                Image(systemName: "ellipsis")
            }.padding(.horizontal)
            
            Rectangle()
                .foregroundColor(.orange)
                .frame(maxWidth: .infinity)
                .frame(height: 400)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged{ value in
                                   currentAmount = value -  1
                        }
                        .onEnded { value in
                            withAnimation(.spring()){
                                currentAmount = 0
                            }
                        }
                )
            HStack{
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }.font(.title)
            .foregroundColor(.purple)
            .padding(.horizontal)
            Text("this is the caption for my photo").font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
            }
            
    }
}

struct MagnificationGestureOfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureOfBootcamp()
    }
}

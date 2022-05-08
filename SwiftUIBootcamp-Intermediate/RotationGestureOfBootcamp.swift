//
//  RotationGestureOfBootcamp.swift
//  SwiftUIBootcamp-Intermediate
//
//  Created by MEWO on 8.05.2022.
//

import SwiftUI

struct RotationGestureOfBootcamp: View {
    
    @State var angle : Angle = Angle(degrees: 0)
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(width: 300, height: 100)
            .background(Color.purple.cornerRadius(15))
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged{ value in
                        angle = value
                    }
                    .onEnded{ value in
                        withAnimation(.spring()){
                            angle = Angle(degrees: 0)
                        }
                    }
            )
    }
}

struct RotationGestureOfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureOfBootcamp()
    }
}

//
//  DragGestureTwoOfBootcamp.swift
//  SwiftUIBootcamp-Intermediate
//
//  Created by MEWO on 8.05.2022.
//

import SwiftUI

struct DragGestureTwoOfBootcamp: View {
    
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.875
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0

    var body: some View {
        ZStack{
            Color.purple.ignoresSafeArea()
            MySignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)

                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            withAnimation(.spring()){
                                currentDragOffsetY = value.translation.height
                            }
                        }
                        .onEnded{value in
                            withAnimation(.spring()){
                                if currentDragOffsetY < -150 {
                                  endingOffsetY = -startingOffsetY
                                    currentDragOffsetY = 0
                                }else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                    currentDragOffsetY = 0
                                }
                                else{
                                    withAnimation(.spring()){
                                        currentDragOffsetY = 0
                                }
                                }
                            }
                        }
                )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DragGestureTwoOfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureTwoOfBootcamp()
    }
}

struct MySignUpView: View {
    var body: some View {
        VStack(spacing: 10){
            Image(systemName: "chevron.up")
                .padding(.top)
            Text("Sign Up")
                .font(.headline)
                .fontWeight(.semibold)
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("This is the description for our app. This app is usable for match for people. Get Start!")
                .multilineTextAlignment(.center)
            Text("CREATE AN ACCOUNT!")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: 200, height: 50)
                .background(Color.black)
                .cornerRadius(10)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
    }
}

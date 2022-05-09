//
//  LongPressGesture.swift
//  SwiftUIBootcamp-Intermediate
//
//  Created by MEWO on 8.05.2022.
//

import SwiftUI

struct LongPressGesture: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        
        VStack{
            Rectangle()
                .fill( isSuccess ? Color.green : Color.red)
                .frame(maxWidth: isComplete ? .infinity : 15)
                .frame(height: 60)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack{
                Text("move")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(15)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 40){
                        (isPressing) in
                            //start of press -> min duration
                            if isPressing {
                                withAnimation(.easeIn(duration: 1.0)){
                                    isComplete = true
                                }
                            }
                            else{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    if !isSuccess{
                                        withAnimation(.easeInOut){
                                            isComplete = false
                                        }
                                    }
                                }
                            }
                        } perform: {
                            // at the min duration
                            withAnimation(.easeInOut){
                                isSuccess = true
                            }
                        }
                Text("reset")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(15)
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }
                    }
            }
        }
struct LongPressGesture_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGesture()
    }
}
}

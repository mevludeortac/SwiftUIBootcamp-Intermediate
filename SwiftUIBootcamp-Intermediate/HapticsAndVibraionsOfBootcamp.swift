//
//  HapticsAndVibraionsOfBootcamp.swift
//  SwiftUIBootcamp-Intermediate
//
//  Created by MEWO on 11.05.2022.
//

import SwiftUI

class HaptickManager{
    static let instance = HaptickManager() //singleton
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style )
        generator.impactOccurred()
    }
}

struct HapticsAndVibraionsOfBootcamp: View {
    var body: some View {
        VStack(spacing:20){
            Button("warning") { HaptickManager.instance.notification(type: .warning) }
            Button("error") { HaptickManager.instance.notification(type: .error) }
            Button("succes") { HaptickManager.instance.notification(type: .success) }
            Divider()
            Button("heavy") { HaptickManager.instance.impact(style: .heavy)}
            Button("light") { HaptickManager.instance.impact(style: .light)}
            Button("medium") { HaptickManager.instance.impact(style: .medium)}
            Button("rigid") { HaptickManager.instance.impact(style: .rigid)}
            Button("soft") { HaptickManager.instance.impact(style: .soft)}
            }
    }
}

struct HapticsAndVibraionsOfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HapticsAndVibraionsOfBootcamp()
    }
}
